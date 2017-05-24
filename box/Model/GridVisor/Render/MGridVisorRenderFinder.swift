import Foundation
import MetalKit

class MGridVisorRenderFinder:MetalRenderableProtocol
{
    static let kSize:Float = 220
    private var texture:MTLTexture?
    private let rotationBuffer:MTLBuffer
    private let spatialSquare:MetalSpatialShapeSquarePositive
    private let positionBuffer:MTLBuffer
    
    init(device:MTLDevice)
    {
        let position:MetalPosition = MetalPosition.zero()
        let rotation:MetalRotation = MetalRotation.none()
        positionBuffer = device.generateBuffer(bufferable:position)
        rotationBuffer = device.generateBuffer(bufferable:rotation)
        spatialSquare = MetalSpatialShapeSquarePositive(
            device:device,
            width:MGridVisorRenderFinder.kSize,
            height:MGridVisorRenderFinder.kSize)
        
        let textureLoader:MTKTextureLoader = MTKTextureLoader(device:device)
        
        guard
        
            let texture:MTLTexture = textureLoader.loadImage(image:#imageLiteral(resourceName: "assetTextureTarget01"))
        
        else
        {
            return
        }
        
        self.texture = texture
    }
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        guard
            
            let texture:MTLTexture = self.texture
            
        else
        {
            return
        }
        
        renderEncoder.render(
            vertex:spatialSquare.vertexBuffer,
            position:positionBuffer,
            rotation:rotationBuffer,
            texture:texture)
    }
}
