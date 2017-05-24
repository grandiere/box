import Foundation
import MetalKit

class MGridVisorRenderFinder:MetalRenderableProtocol
{
    static let kSize:CGFloat = 220
    
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
