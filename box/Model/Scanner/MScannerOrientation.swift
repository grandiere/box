import Foundation
import MetalKit

class MScannerOrientation
{
    static let kVerticalMultiplier:Float = 5
    static let kHorizontalMultiplier:Float = 10
    
    //MARK: public
    
    func positionBuffer(
        device:MTLDevice,
        userHeading:Float,
        moveVertical:Float,
        itemHeading:Float) -> MTLBuffer?
    {
        return nil
    }
}
