import Foundation
import MetalKit

class MetalSpatialBase
{
    let vertexBuffer:MTLBuffer
    
    init(vertexBuffer:MTLBuffer)
    {
        self.vertexBuffer = vertexBuffer
    }
    
    init(
        device:MTLDevice,
        width:Float,
        height:Float)
    {
        let width_2:Float = width / 2.0
        let height_2:Float = height / 2.0
        let top:Float = height_2
        let bottom:Float = -height_2
        let left:Float = -width_2
        let right:Float = width_2
        
        let topLeft:MetalVertex = MetalVertex(
            positionX:left,
            positionY:top)
        let topRight:MetalVertex = MetalVertex(
            positionX:right,
            positionY:top)
        let bottomLeft:MetalVertex = MetalVertex(
            positionX:left,
            positionY:bottom)
        let bottomRight:MetalVertex = MetalVertex(
            positionX:right,
            positionY:bottom)
        
        let vertexFace:MetalVertexFace = MetalVertexFace(
            topLeft:topLeft,
            topRight:topRight,
            bottomLeft:bottomLeft,
            bottomRight:bottomRight)
        
        vertexBuffer = device.generateBuffer(bufferable:vertexFace)
    }
}
