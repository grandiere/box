import UIKit
import MetalKit

class MScannerRenderBook:MetalRenderableProtocol
{
    let texture:MTLTexture
    private var rotation:MetalRotation
    private let spatialSquare:MetalSpatialShapeSquarePositive
    private let positionBuffer:MTLBuffer
    private let kWidth:Float = 100
    private let kHeight:Float = 100
    
    init(
        device:MTLDevice,
        texture:MTLTexture)
    {
        self.texture = texture
        let position:MetalPosition = MetalPosition.zero()
        rotation = MetalRotation.none()
        positionBuffer = device.generateBuffer(bufferable:position)
        spatialSquare = MetalSpatialShapeSquarePositive(
            device:device,
            width:kWidth,
            height:kHeight)
    }
    
    //MARK: public
    
    func motionRotate(radians:Float)
    {
        rotation = MetalRotation(radians:radians)
    }
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        let rotationBuffer:MTLBuffer = renderEncoder.device.generateBuffer(
            bufferable:rotation)
        
        renderEncoder.render(
            vertex:spatialSquare.vertexBuffer,
            position:positionBuffer,
            rotation:rotationBuffer,
            texture:texture)
    }
}
