import UIKit

class MetalProjectionMatrix:MetalBufferableProtocol
{
    let minY:Float
    let maxY:Float
    let minX:Float
    let maxX:Float
    private let ratioX:Float
    private let ratioY:Float
    
    init()
    {
        let size:CGSize = UIScreen.main.bounds.size
        let scale:Float = Float(UIScreen.main.scale)
        let width:Float = Float(size.width)
        let height:Float = Float(size.height)
        let width_2:Float = width / 2.0
        let height_2:Float = height / 2.0
        let scaledWidth:Float = width / scale
        let scaledHeight:Float = height / scale
        minY = -height_2
        maxY = height_2
        minX = -width
        maxX = width_2
        ratioX = scaledWidth
        ratioY = scaledHeight
    }
    
    //MARK: bufferableProtocol
    
    func buffer() -> [Float]
    {
        let bufferArray:[Float] = [
            ratioX,
            ratioY
        ]
        
        return bufferArray
    }
}
