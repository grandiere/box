import Foundation
import MetalKit

class MGridVisorRenderFinder:MetalRenderableProtocol
{
    static let kSize:Float = 220
    private weak var controller:CGridVisor!
    private let sequence:MGridVisorRenderFinderSequence
    private let rotationBuffer:MTLBuffer
    private let spatialSquare:MetalSpatialShapeSquarePositive
    private let positionBuffer:MTLBuffer
    private let colourBuffer:MTLBuffer
    
    init(
        controller:CGridVisor,
        device:MTLDevice,
        textureLoader:MTKTextureLoader)
    {
        let position:MetalPosition = MetalPosition.zero()
        let rotation:MetalRotation = MetalRotation.none()
        positionBuffer = device.generateBuffer(bufferable:position)
        rotationBuffer = device.generateBuffer(bufferable:rotation)
        colourBuffer = MetalColour.color(
            device:device,
            originalColor:UIColor.gridBlue)
        spatialSquare = MetalSpatialShapeSquarePositive(
            device:device,
            width:MGridVisorRenderFinder.kSize,
            height:MGridVisorRenderFinder.kSize)
        sequence = MGridVisorRenderFinderSequence(textureLoader:textureLoader)
        self.controller = controller
    }
    
    //MARK: renderable Protocol
    
    func render(manager:MetalRenderManager)
    {
        if let _:MGridAlgoItem = controller.targeting
        {
            guard
                
                let texture:MTLTexture = sequence.current()
                
            else
            {
                return
            }
            
            manager.renderColour(
                vertex:spatialSquare.vertexBuffer,
                position:positionBuffer,
                rotation:rotationBuffer,
                colour:colourBuffer,
                texture:texture)
        }
    }
}
