import Foundation
import CoreLocation
import MetalKit

class MGridVisorRenderAlgo:MetalRenderableProtocol
{
    var userHeading:Float
    var moveVertical:Float
    weak var render:MGridVisorRender!
    private weak var textureLoader:MTKTextureLoader!
    private weak var device:MTLDevice!
    private(set) var items:[MGridAlgoItem]
    private let textures:MGridVisorRenderTextures
    private let vertexes:MGridVisorRenderVertexes
    
    init(
        device:MTLDevice,
        textureLoader:MTKTextureLoader)
    {
        self.device = device
        self.textureLoader = textureLoader
        moveVertical = 0
        userHeading = 0
        items = []
        removeAlgoItems = []
        textures = MGridVisorRenderTextures(textureLoader:textureLoader)
        vertexes = MGridVisorRenderVertexes(device:device)
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedDestroyAlgo(sender:)),
            name:Notification.destroyAlgoRendered,
            object:nil)
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: notified
    
    @objc func notifiedDestroyAlgo(sender notification:Notification)
    {
        guard
        
            let algoItem:MGridAlgoItem = notification.object as? MGridAlgoItem
        
        else
        {
            return
        }
        
        removeAlgoItems.append(algoItem)
    }
    
    //MARK: private
    
    private func renderPositionedItem(
        manager:MetalRenderManager,
        rotationBuffer:MTLBuffer,
        positioned:MGridVisorRenderAlgoItem)
    {
        guard
            
            let texture:MTLTexture = positioned.item.currentTexture,
            let vertex:MTLBuffer = positioned.item.currentVertex?.vertexBuffer
        
        else
        {
            return
        }
        
        let positionBuffer:MTLBuffer = device.generateBuffer(
            bufferable:positioned.position)
        
        manager.renderSimple(
            vertex:vertex,
            position:positionBuffer,
            rotation:rotationBuffer,
            texture:texture)
    }
    
    private func cleanRemoveitems()
    {
        for removeItem:MGridAlgoItem in removeAlgoItems
        {
            let countItems:Int = items.count
            
            for indexItem:Int in 0 ..< countItems
            {
                let item:MGridAlgoItem = items[indexItem]
                
                if item === removeItem
                {
                    items.remove(at:indexItem)
                    
                    break
                }
            }
        }
        
        removeAlgoItems = []
    }
    
    //MARK: public
    
    func renderAlgoList(nearItems:[MGridAlgoItem])
    {
        var items:[MGridAlgoItem] = []
        
        for nearItem:MGridAlgoItem in nearItems
        {
            guard
                
                let multipliedHeading:Float = render.controller.orientation?.normalHeading(
                    rawHeading:nearItem.heading)
            else
            {
                continue
            }
            
            nearItem.multipliedHeading = multipliedHeading
            items.append(nearItem)
        }
        
        self.items = items
    }
    
    //MARK: renderable Protocol
    
    func render(manager:MetalRenderManager)
    {
        guard
            
            let rotationBuffer:MTLBuffer = render.rotationBuffer
            
        else
        {
            return
        }
        
        guard
            
            let orientation:MGridVisorOrientation = render.controller.orientation
        
        else
        {
            return
        }
        
        var items:[MGridAlgoItem] = []
        var targeted:MGridVisorRenderAlgoItem?
        
        for item:MGridAlgoItem in self.items
        {
            guard
                
                let validItem:MGridAlgoItem = validate(item:item)
            
            else
            {
                continue
            }
            
            items.append(validItem)
            
            guard
                
                let positioned:MGridVisorRenderAlgoItemPositioned = MGridVisorRenderAlgoItemPositioned(
                    orientation:orientation,
                    item:validItem,
                    userHeading:userHeading,
                    moveVertical:moveVertical)
            
            else
            {
                return
            }
            
            if let deltaPosition:Float = positioned.deltaPosition
            {
                if let currentTargeted:MGridVisorRenderAlgoItemPositioned = targeted
                {
                    if let currentDelta:Float = currentTargeted.deltaPosition
                    {
                        if deltaPosition < currentDelta
                        {
                            renderPositionedItem(
                                manager:manager,
                                rotationBuffer:rotationBuffer,
                                positioned:currentTargeted)
                            
                            targeted = positioned
                        }
                        else
                        {
                            renderPositionedItem(
                                manager:manager,
                                rotationBuffer:rotationBuffer,
                                positioned:positioned)
                        }
                    }
                }
                else
                {
                    targeted = positioned
                }
            }
            else
            {
                renderPositionedItem(
                    manager:manager,
                    rotationBuffer:rotationBuffer,
                    positioned:positioned)
            }
        }
        
        self.items = items
        
        if let targeted:MGridVisorRenderAlgoItemPositioned = targeted
        {
            targeted.item.modeTargeted()
            
            renderPositionedItem(
                manager:manager,
                rotationBuffer:rotationBuffer,
                positioned:targeted)
            
            render.controller.targeting = targeted.item.model
        }
        else
        {
            render.controller.targeting = nil
        }
    }
}
