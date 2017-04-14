import Foundation

class MScannerOrientationPortrait:MScannerOrientation
{
    override func itemPosition(
        userHeading:Float,
        moveVertical:Float,
        itemHeading:Float) -> MetalPosition?
    {
        let normalUserHeading:Float
        
        if (itemHeading < kItemMaxThreshold) && (userHeading < 0 && userHeading > kMinThreshold)
        {
            normalUserHeading = userHeading * kHorizontalMultiplier
        }
        else
        {
            normalUserHeading = normalHeading(rawHeading:userHeading)
        }
        
        let positionX:Float = itemHeading - normalUserHeading
        let positionY:Float = moveVertical * kVerticalMultiplier
        
        let position:MetalPosition = MetalPosition(
            positionX:positionX,
            positionY:positionY)
        
        return position
    }
}
