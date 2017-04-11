import Foundation

class MetalSpatialDirectionNegative:MetalSpatialDirection
{
    private let kTop:Float = 0
    private let kBottom:Float = 1
    private let kLeft:Float = 1
    private let kRight:Float = 0
    
    init()
    {
        super.init(
            top:kTop,
            bottom:kBottom,
            left:kLeft,
            right:kRight)
    }
}
