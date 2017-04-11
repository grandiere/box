import Foundation

class MetalVertexFace:MetalBufferableProtocol
{
    private let topLeft:MetalVertex
    private let topRight:MetalVertex
    private let bottomLeft:MetalVertex
    private let bottomRight:MetalVertex
    
    init(
        topLeft:MetalVertex,
        topRight:MetalVertex,
        bottomLeft:MetalVertex,
        bottomRight:MetalVertex)
    {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
    }
    
    //MARK: bufferableProtocol
    
    func buffer() -> [Float]
    {
        var bufferArray:[Float] = []
        bufferArray.append(contentsOf:topLeft.buffer())
        bufferArray.append(contentsOf:bottomLeft.buffer())
        bufferArray.append(contentsOf:topRight.buffer())
        bufferArray.append(contentsOf:topRight.buffer())
        bufferArray.append(contentsOf:bottomLeft.buffer())
        bufferArray.append(contentsOf:bottomRight.buffer())
        
        return bufferArray
    }
}
