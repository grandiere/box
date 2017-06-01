import Foundation

class MetalVertexTextured:MetalVertex
{
    private let horizontal:Float
    private let vertical:Float
    
    init(
        positionX:Float,
        positionY:Float,
        horizontal:Float,
        vertical:Float)
    {
        self.horizontal = horizontal
        self.vertical = vertical
        
        super.init(
            positionX:positionX,
            positionY:positionY)
    }
    
    override func buffer() -> [Float]
    {
        var bufferArray:[Float] = super.buffer()
        bufferArray.append(horizontal)
        bufferArray.append(vertical)
        
        return bufferArray
    }
}
