import Foundation

class MScannerOrientation
{
    static let kVerticalMultiplier:Float = 5
    static let kHorizontalMultiplier:Float = 10
    let k360Deg:Float = 360
    let k180Deg:Float = 180
    
    //MARK: public
    
    final func normalHeading(rawHeading:Float) -> Float
    {
        if rawHeading >= 0
        {
            return rawHeading
        }
        
        return k360Deg - rawHeading
    }
    
    func itemPosition(
        userHeading:Float,
        moveVertical:Float,
        itemHeading:Float) -> MetalPosition?
    {
        return nil
    }
}
