import Foundation
import MetalKit

class MGridVisorRenderFinder:MetalRenderableProtocol
{
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
