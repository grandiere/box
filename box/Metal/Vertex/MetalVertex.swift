import Foundation

class MetalVertex:MetalBufferableProtocol
{
    private let positionX:Float
    private let positionY:Float
    
    init(
        positionX:Float,
        positionY:Float)
    {
        self.positionX = positionX
        self.positionY = positionY
    }
    
    //MARK: bufferableProtocol
    
    func buffer() -> [Float]
    {
        let bufferArray:[Float] = [
            positionX,
            positionY
        ]
        
        return bufferArray
    }
}
