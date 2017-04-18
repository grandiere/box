import Foundation
import CoreLocation
import MetalKit

class MGridVisorRenderAlgo:MetalRenderableProtocol
{
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
        let rotationBuffer:MTLBuffer = renderEncoder.device.generateBuffer(
            bufferable:rotation)
        
        for item:MGridVisorRenderAlgoItem in items
        {
            let itemHeading:Float = item.model.heading
            
            guard
                
                let position:MetalPosition = controller.orientation?.itemPosition(
                    userHeading:userHeading,
                    moveVertical:moveVertical,
                    itemHeading:itemHeading)
                
            else
            {
                continue
            }
            
            let positionBuffer:MTLBuffer = device.generateBuffer(
                bufferable:position)
            
            renderEncoder.render(
                vertex:item.spatialSquare.vertexBuffer,
                position:positionBuffer,
                rotation:rotationBuffer,
                texture:item.texture)
        }
    }
}
