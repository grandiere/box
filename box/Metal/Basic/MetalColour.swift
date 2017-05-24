import UIKit
import MetalKit

class MetalColor:MetalBufferableProtocol
{
    class func color(device:MTLDevice, originalColor:UIColor) -> MTLBuffer
    {
        let color:MetalColor = MetalColor(originalColor:originalColor)
        let metalBuffer:MTLBuffer = device.generateBuffer(
            bufferable:color)
        
        return metalBuffer
    }
    
    private let red:Float
    private let green:Float
    private let blue:Float
    private let alpha:Float
    
    private init(originalColor:UIColor)
    {
        var red:CGFloat = 0
        var green:CGFloat = 0
        var blue:CGFloat = 0
        var alpha:CGFloat = 0
        
        originalColor.getRed(
            &red,
            green:&green,
            blue:&blue,
            alpha:&alpha)
        
        self.red = Float(red)
        self.green = Float(green)
        self.blue = Float(blue)
        self.alpha = Float(alpha)
    }
    
    //MARK: bufferableProtocol
    
    func buffer() -> [Float]
    {
        let bufferArray:[Float] = [
            red,
            green,
            blue
        ]
        
        return bufferArray
    }
}
