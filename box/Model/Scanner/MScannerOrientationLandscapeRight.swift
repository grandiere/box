import Foundation

class MScannerOrientationLandscapeRight:MScannerOrientation
{
    override func itemPosition(
        userHeading:Float,
        moveVertical:Float,
        itemHeading:Float) -> MetalPosition?
    {
        let positionX:Float
        let positionY:Float
        
        if userHeading >= 0
        {
            let headingMultiplied:Float = userHeading * kHorizontalMultiplier
            positionY = -(headingMultiplied + itemHeading)
        }
        else
        {
            let headingMultiplied:Float = userHeading * kHorizontalMultiplier
            positionY = itemHeading - headingMultiplied
        }
        
        positionX = -moveVertical
        
        let position:MetalPosition = MetalPosition(
            positionX:positionX,
            positionY:positionY)

        return position
    }
}
