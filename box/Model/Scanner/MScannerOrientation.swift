import Foundation

class MScannerOrientation
{
    let kVerticalMultiplier:Float = 5
    let kHorizontalMultiplier:Float = 10
    let k360Deg:Float = 360
    let k180Deg:Float = 180
    let kMinThreshold:Float = -29
    let kItemMinThreshold:Float = 3500
    let kItemMaxThreshold:Float = 100
    
    //MARK: public
    
    final func normalHeading(rawHeading:Float) -> Float
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
    
    func itemPosition(
        userHeading:Float,
        moveVertical:Float,
        itemHeading:Float) -> MetalPosition?
    {
        return nil
    }
}
