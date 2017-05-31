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
    private(set) var items:[String:MGridAlgoItem]
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
        items = [:]
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
        
        items.removeValue(forKey:algoItem.firebaseId)
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
    
    //MARK: public
    
    func renderAlgoList(nearItems:[MGridAlgoItem])
    {
        var items:[String:MGridAlgoItem] = [:]
        
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
            items[nearItem.firebaseId] = nearItem
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
        
        var targeted:MGridVisorRenderAlgoItem?
        let items:[MGridAlgoItem] = Array(self.items.values)
        
        for item:MGridAlgoItem in items
        {   
            guard
                
                let positioned:MGridVisorRenderAlgoItem = MGridVisorRenderAlgoItem(
                    orientation:orientation,
                    model:item,
                    userHeading:userHeading,
                    moveVertical:moveVertical)
            
            else
            {
                return
            }
            
            if let deltaPosition:Float = positioned.deltaPosition
            {
                if let currentTargeted:MGridVisorRenderAlgoItem = targeted
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
