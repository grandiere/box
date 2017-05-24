import Foundation
import MetalKit

class MGridVisorRenderFinder:MetalRenderableProtocol
{
    static let kSize:Float = 220
    private weak var controller:CGridVisor!
    private weak var algoItem:MGridAlgoItem?
    private var colourBuffer:MTLBuffer?
    private let sequence:MGridVisorRenderFinderSequence
    private let rotationBuffer:MTLBuffer
    private let spatialSquare:MetalSpatialShapeSquarePositive
    private let positionBuffer:MTLBuffer
    
    init(
        controller:CGridVisor,
        device:MTLDevice,
        textureLoader:MTKTextureLoader)
    {
        let position:MetalPosition = MetalPosition.zero()
        let rotation:MetalRotation = MetalRotation.none()
        positionBuffer = device.generateBuffer(bufferable:position)
        rotationBuffer = device.generateBuffer(bufferable:rotation)
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
        if let algoItem:MGridAlgoItem = controller.targeting
        {
            if colourBuffer == nil || algoItem !== self.algoItem
            {
                self.algoItem = algoItem
                
                colourBuffer = MetalColour.color(
                    device:manager.device,
                    originalColor:algoItem.textureColour())
            }
            
            guard
                
                let texture:MTLTexture = sequence.current(),
                let colourBuffer:MTLBuffer = self.colourBuffer
                
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
        else
        {
            sequence.restart()
        }
    }
}
