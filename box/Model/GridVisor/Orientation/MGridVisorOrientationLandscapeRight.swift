import Foundation

class MGridVisorOrientationLandscapeRight:MGridVisorOrientation
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
        
        let positionY:Float = itemHeading - normalUserHeading
        let positionX:Float = moveVertical / -kVerticalDivider
        
        let position:MetalPosition = MetalPosition(
            positionX:positionX,
            positionY:positionY)
        
        return position
    }
}
