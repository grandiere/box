import Foundation

class MetalPosition:MetalBufferableProtocol
{
    class func zero() -> MetalPosition
    {
        let position:MetalPosition = MetalPosition(positionX:0, positionY:0)
        
        return position
    }
    
    var positionX:Float
    var positionY:Float
    
    init(positionX:Float, positionY:Float)
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
