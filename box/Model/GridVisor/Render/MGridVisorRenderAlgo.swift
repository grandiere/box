import Foundation
import CoreLocation
import MetalKit

class MGridVisorRenderAlgo:MetalRenderableProtocol
{
    static let kMaxTarget:Float = 85
    
    var userHeading:Float
    private weak var textureLoader:MTKTextureLoader!
    private weak var controller:CGridVisor!
    private weak var device:MTLDevice!
    private(set) var items:[MGridVisorRenderAlgoItem]
    private var removeAlgoItems:[MGridAlgoItem]
    private var rotation:MetalRotation
    private var moveVertical:Float
    
    init(
        controller:CGridVisor,
        device:MTLDevice,
        textureLoader:MTKTextureLoader)
    {
        self.controller = controller
        self.device = device
        self.textureLoader = textureLoader
        rotation = MetalRotation.none()
        moveVertical = 0
        userHeading = 0
        items = []
        removeAlgoItems = []
        
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
        renderEncoder:MTLRenderCommandEncoder,
        rotationBuffer:MTLBuffer,
        positioned:MGridVisorRenderAlgoItemPositioned)
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
        
        renderEncoder.render(
            vertex:vertex,
            position:positionBuffer,
            rotation:rotationBuffer,
            texture:texture)
    }
    
    private func validate(item:MGridVisorRenderAlgoItem) -> MGridVisorRenderAlgoItem?
    {
        var validItem:MGridVisorRenderAlgoItem? = item
        let algo:MGridAlgoItem = item.model
        
        let currentRemoveItems:[MGridAlgoItem] = self.removeAlgoItems
        var removeAlgoItems:[MGridAlgoItem] = []
        
        for removeItem:MGridAlgoItem in currentRemoveItems
        {
            if removeItem === algo
            {
                validItem = nil
            }
            else
            {
                removeAlgoItems.append(removeItem)
            }
        }
        
        self.removeAlgoItems = removeAlgoItems
        
        return validItem
    }
    
    //MARK: public
    
    func renderAlgoList(nearItems:[MGridAlgoItem])
    {
        var items:[MGridVisorRenderAlgoItem] = []
        
        for nearItem:MGridAlgoItem in nearItems
        {
            guard
                
                let multipliedHeading:Float = controller.orientation?.normalHeading(
                    rawHeading:nearItem.heading),
                let item:MGridVisorRenderAlgoItem = MGridVisorRenderAlgoItem(
                    device:device,
                    textureLoader:textureLoader,
                    model:nearItem)
            
            else
            {
                continue
            }
            
            nearItem.multipliedHeading = multipliedHeading
            items.append(item)
        }
        
        self.items = items
    }
    
    func motionRotate(
        moveHorizontal:Float,
        moveVertical:Float)
    {
        self.moveVertical = moveVertical
        rotation = MetalRotation(radians:moveHorizontal)
    }
    
    //MARK: renderable Protocol
    
    func render(manager:MetalRenderManager)
    {
        guard
            
            let orientation:MGridVisorOrientation = controller.orientation
        
        else
        {
            return
        }
        
        var items:[MGridVisorRenderAlgoItem] = []
        let rotationBuffer:MTLBuffer = renderEncoder.device.generateBuffer(
            bufferable:rotation)
        var targeted:MGridVisorRenderAlgoItemPositioned?
        
        for item:MGridVisorRenderAlgoItem in self.items
        {
            guard
                
                let validItem:MGridVisorRenderAlgoItem = validate(item:item)
            
            else
            {
                continue
            }
            
            items.append(validItem)
            validItem.modeStandBy()
            
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
                                renderEncoder:renderEncoder,
                                rotationBuffer:rotationBuffer,
                                positioned:currentTargeted)
                            
                            targeted = positioned
                        }
                        else
                        {
                            renderPositionedItem(
                                renderEncoder:renderEncoder,
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
                    renderEncoder:renderEncoder,
                    rotationBuffer:rotationBuffer,
                    positioned:positioned)
            }
        }
        
        self.items = items
        
        if let targeted:MGridVisorRenderAlgoItemPositioned = targeted
        {
            targeted.item.modeTargeted()
            
            renderPositionedItem(
                renderEncoder:renderEncoder,
                rotationBuffer:rotationBuffer,
                positioned:targeted)
            
            controller.targeting = targeted.item.model
        }
        else
        {
            controller.targeting = nil
        }
    }
}
