import Foundation

class MGridVisorOrientationLandscapeLeft:MGridVisorOrientationProtocol
{
    func itemPosition(
        userHeading:Float,
        moveVertical:Float,
        itemHeading:Float) -> MetalPosition
    {
        let normalUserHeading:Float
        
        if (itemHeading < MGridVisorOrientation.kItemMaxThreshold) && (userHeading < 0 && userHeading > MGridVisorOrientation.kMinThreshold)
        {
            normalUserHeading = userHeading * MGridVisorOrientation.kHorizontalMultiplier
        }
        else
        {
            normalUserHeading = MGridVisorOrientation.normalHeading(rawHeading:userHeading)
        }
        
        let positionY:Float = normalUserHeading - itemHeading
        let positionX:Float = moveVertical / MGridVisorOrientation.kVerticalDivider
        
        let position:MetalPosition = MetalPosition(
            positionX:positionX,
            positionY:positionY)
        
        return position
    }
}
