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
    private let kMaxTarget:Float = 85
    
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
    
    private func renderStandby(
        manager:MetalRenderManager,
        item:MGridVisorRenderAlgoItem)
    {
        manager.renderSimple(
            vertex:vertex,
            position:positionBuffer,
            rotation:rotationBuffer,
            texture:texture)
    }
    
    private func renderTargeted(
        manager:MetalRenderManager,
        item:MGridVisorRenderAlgoItem)
    {
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

        let orientation:MGridVisorOrientationProtocol = render.controller.orientation
        var targeted:MGridVisorRenderAlgoItem?
        let items:[MGridAlgoItem] = Array(self.items.values)
        
        for item:MGridAlgoItem in items
        {
            let position:MetalPosition = orientation.itemPosition(
                userHeading:userHeading,
                moveVertical:moveVertical,
                itemHeading:item.multipliedHeading)
            let positioned:MGridVisorRenderAlgoItem = MGridVisorRenderAlgoItem(
                device:device,
                model:item,
                position:position)
            
            if let currentTargeted:MGridVisorRenderAlgoItem = targeted
            {
                if positioned.deltaPosition < currentTargeted.deltaPosition
                {
                    renderPositionedItem(
                        manager:manager,
                        rotationBuffer:rotationBuffer,
                        positioned:currentTargeted)
                    
                    targeted = positioned
                }
            }
            else
            {
                targeted = positioned
            }
        }
        
        if let currentTargeted:MGridVisorRenderAlgoItem = targeted
        {
            renderPositionedItem(
                manager:manager,
                rotationBuffer:rotationBuffer,
                positioned:currentTargeted)
            
            render.controller.targeting = currentTargeted.model
        }
        else
        {
            render.controller.targeting = nil
        }
    }
}
