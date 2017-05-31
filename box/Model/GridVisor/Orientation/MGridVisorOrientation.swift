import Foundation

class MGridVisorOrientation
{
    static let k360Deg:Float = 360
    static let kHorizontalMultiplier:Float = 10
    static let kVerticalMultiplier:Float = 5
    static let kMinThreshold:Float = -29
    static let kItemMaxThreshold:Float = 100
    static let kVerticalDivider:Float = 2
    
    class func normalHeading(rawHeading:Float) -> Float
    {
        let normal:Float
        
        if rawHeading >= 0
        {
            normal = rawHeading
        }
        else
        {
            normal = k360Deg + rawHeading
        }
        
        let normalMultiplied:Float = normal * kHorizontalMultiplier
        
        return normalMultiplied
    }
}
