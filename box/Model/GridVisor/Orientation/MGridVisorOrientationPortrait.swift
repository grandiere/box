import Foundation

class MGridVisorOrientationPortrait:MGridVisorOrientationProtocol
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
        
        let positionX:Float = itemHeading - normalUserHeading
        let positionY:Float = moveVertical * MGridVisorOrientation.kVerticalMultiplier
        
        let position:MetalPosition = MetalPosition(
            positionX:positionX,
            positionY:positionY)
        
        return position
    }
}
