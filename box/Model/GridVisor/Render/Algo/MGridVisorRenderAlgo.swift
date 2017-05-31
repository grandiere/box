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
    
    private func positionFor(item:MGridAlgoItem) -> MGridVisorRenderAlgoItem
    {
        let position:MetalPosition = render.controller.orientation.itemPosition(
            userHeading:userHeading,
            moveVertical:moveVertical,
            itemHeading:item.multipliedHeading)
        let positioned:MGridVisorRenderAlgoItem = MGridVisorRenderAlgoItem(
            device:device,
            model:item,
            position:position)
        
        return positioned
    }
    
    private func renderStandby(
        manager:MetalRenderManager,
        item:MGridVisorRenderAlgoItem,
        rotation:MTLBuffer)
    {
        guard
            
            let texture:MTLTexture = item.model.textureStandby(textures:textures)
        
        else
        {
            return
        }
        
        manager.renderSimple(
            vertex:vertexes.vertexStandby,
            position:item.positionBuffer,
            rotation:rotation,
            texture:texture)
    }
    
    private func renderTargeted(
        manager:MetalRenderManager,
        item:MGridVisorRenderAlgoItem,
        rotation:MTLBuffer)
    {
        if render.controller.targeting !== item.model
        {
            textures.restart()
        }
        
        guard
            
            let texture:MTLTexture = item.model.textureTargeted(textures:textures)
            
        else
        {
            return
        }
        
        manager.renderSimple(
            vertex:vertexes.vertexTargeted,
            position:item.positionBuffer,
            rotation:rotation,
            texture:texture)
        
        render.controller.targeting = item.model
    }
    
    //MARK: public
    
    func renderAlgoList(nearItems:[MGridAlgoItem])
    {
        var items:[String:MGridAlgoItem] = [:]
        
        for nearItem:MGridAlgoItem in nearItems
        {
            nearItem.multipliedHeading = MGridVisorOrientation.normalHeading(
                    rawHeading:nearItem.heading)
            items[nearItem.firebaseId] = nearItem
        }
        
        self.items = items
    }
    
    //MARK: renderable Protocol
    
    func render(manager:MetalRenderManager)
    {
        guard
            
            let rotation:MTLBuffer = render.rotationBuffer
            
        else
        {
            return
        }

        var targeted:MGridVisorRenderAlgoItem?
        let items:[MGridAlgoItem] = Array(self.items.values)
        
        for item:MGridAlgoItem in items
        {
            let positioned:MGridVisorRenderAlgoItem = positionFor(item:item)
            
            if let currentTargeted:MGridVisorRenderAlgoItem = targeted
            {
                if positioned.deltaHorizontal < currentTargeted.deltaHorizontal
                {
                    renderStandby(
                        manager:manager,
                        item:currentTargeted,
                        rotation:rotation)
                    
                    targeted = positioned
                }
                else
                {
                    renderStandby(
                        manager:manager,
                        item:positioned,
                        rotation:rotation)
                }
            }
            else
            {
                targeted = positioned
            }
        }
        
        if let currentTargeted:MGridVisorRenderAlgoItem = targeted
        {
            if currentTargeted.deltaHorizontal < kMaxTarget && currentTargeted.deltaVertical < kMaxTarget
            {
                renderTargeted(
                    manager:manager,
                    item:currentTargeted,
                    rotation:rotation)
            }
            else
            {
                renderStandby(
                    manager:manager,
                    item:currentTargeted,
                    rotation:rotation)
                
                render.controller.targeting = nil
            }
        }
        else
        {
            render.controller.targeting = nil
        }
    }
}
