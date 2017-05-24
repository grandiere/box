import Foundation
import MetalKit

extension MTLRenderCommandEncoder
{
    func projectionMatrix(projection:MTLBuffer)
    {
        setVertexBuffer(
            projection,
            offset:0,
            at:MetalConstants.kProjectionIndex)
    }
}
