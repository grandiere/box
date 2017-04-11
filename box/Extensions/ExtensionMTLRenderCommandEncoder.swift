import Foundation
import MetalKit

extension MTLRenderCommandEncoder
{
    func render(
        vertex:MTLBuffer,
        position:MTLBuffer,
        rotation:MTLBuffer,
        texture:MTLTexture)
    {
        setVertexBuffer(
            vertex,
            offset:0,
            at:MetalConstants.kVertexIndex)
        setVertexBuffer(
            position,
            offset:0,
            at:MetalConstants.kPositionIndex)
        setVertexBuffer(
            rotation,
            offset:0,
            at:MetalConstants.kRotationIndex)
        setFragmentTexture(
            texture,
            at:MetalConstants.kTextureIndex)
        drawPrimitives(
            type:MetalConstants.kPrimitiveType,
            vertexStart:0,
            vertexCount:MetalConstants.kPrimitiveCount)
    }
    
    func projectionMatrix(projection:MTLBuffer)
    {
        setVertexBuffer(
            projection,
            offset:0,
            at:MetalConstants.kProjectionIndex)
    }
}
