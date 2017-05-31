import Foundation
import MetalKit

class MGridVisorRenderFinder:MetalRenderableProtocol
{
    weak var render:MGridVisorRender!
    private weak var algoItem:MGridAlgoItem?
    private var colourBuffer:MTLBuffer?
    private let sequence:MGridVisorRenderFinderSequence
    private let spatialSquare:MetalSpatialShapeSquarePositive
    private let positionBuffer:MTLBuffer
    private let kSize:Float = 220
    
    init(
        device:MTLDevice,
        textureLoader:MTKTextureLoader)
    {
        let position:MetalPosition = MetalPosition.zero()
        positionBuffer = device.generateBuffer(bufferable:position)
        spatialSquare = MetalSpatialShapeSquarePositive(
            device:device,
            width:kSize,
            height:kSize)
        sequence = MGridVisorRenderFinderSequence(textureLoader:textureLoader)
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
        
        if let algoItem:MGridAlgoItem = render.controller.targeting
        {
            if colourBuffer == nil || algoItem !== self.algoItem
            {
                self.algoItem = algoItem
                
                colourBuffer = MetalColour.color(
                    device:manager.device,
                    originalColor:algoItem.overlayColour)
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
