import Foundation

class MetalRotation:MetalBufferableProtocol
{
    class func none() -> MetalRotation
    {
        let rotation:MetalRotation = MetalRotation(radians:0)
        
        return rotation
    }
    
    private let bufferArray:[Float]
    
    init(radians:Float)
    {
        let sinX:Float = sin(radians)
        let cosX:Float = cos(radians)

        bufferArray = [
            cosX,sinX,
            -sinX,cosX
        ]
    }
    
    //MARK: bufferableProtocol
    
    func buffer() -> [Float]
    {
        return bufferArray
    }
}
