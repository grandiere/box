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
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        guard
            
            let orientation:MGridVisorOrientation = controller.orientation
        
        else
        {
            return
        }
        
        let rotationBuffer:MTLBuffer = renderEncoder.device.generateBuffer(
            bufferable:rotation)
        var targeted:MGridVisorRenderAlgoItemPositioned?
        
        for item:MGridVisorRenderAlgoItem in items
        {
            item.modeStandBy()
            
            guard
                
                let positioned:MGridVisorRenderAlgoItemPositioned = MGridVisorRenderAlgoItemPositioned(
                    orientation:orientation,
                    item:item,
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
