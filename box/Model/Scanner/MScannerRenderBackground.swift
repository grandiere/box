import UIKit
import MetalKit

class MScannerRenderBackground:MetalRenderableProtocol
{
    var texture:MTLTexture?
    private let rotationBuffer:MTLBuffer
    private let spatialSquare:MetalSpatialShapeSquarePositive
    private let positionBuffer:MTLBuffer
    private let kCameraWidth:Float = 480
    private let kCameraHeight:Float = 640
    
    init(device:MTLDevice)
    {
        let screenSize:CGRect = UIScreen.main.bounds
        let screenWidth:Float = Float(screenSize.width)
        let screenHeight:Float = Float(screenSize.height)
        let deltaWidth:Float = kCameraWidth / screenWidth
        let deltaHeight:Float = kCameraHeight / screenHeight
        let minDelta:Float = min(deltaWidth, deltaHeight)
        let textureWidth:Float = kCameraWidth / minDelta
        let textureHeight:Float = kCameraHeight / minDelta
        
        let position:MetalPosition = MetalPosition.zero()
        let rotation:MetalRotation = MetalRotation.none()
        positionBuffer = device.generateBuffer(bufferable:position)
        rotationBuffer = device.generateBuffer(bufferable:rotation)
        spatialSquare = MetalSpatialShapeSquarePositive(
            device:device,
            width:textureWidth,
            height:textureHeight)
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
