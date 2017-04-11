import UIKit

class MetalProjection
{
    let minY:Float
    let maxY:Float
    let minX:Float
    let maxX:Float
    let projectionBuffer:MTLBuffer
    
    init(device:MTLDevice)
    {
        let projectionMatrix:MetalProjectionMatrix = MetalProjectionMatrix()
        
        projectionBuffer = device.generateBuffer(
            bufferable:projectionMatrix)
        minY = projectionMatrix.minY
        maxY = projectionMatrix.maxY
        minX = projectionMatrix.minX
        maxX = projectionMatrix.maxX
    }
}
