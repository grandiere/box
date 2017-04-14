import Foundation

class MScannerOrientationPortrait:MScannerOrientation
{
    override func itemPosition(
        userHeading:Float,
        moveVertical:Float,
        itemHeading:Float) -> MetalPosition?
    {
        let headingMultiplied:Float = userHeading * MScannerOrientation.kHorizontalMultiplier
        let verticalMultiplied:Float = moveVertical * MScannerOrientation.kVerticalMultiplier
        let positionX:Float
        let positionY:Float
        
        if userHeading >= 0
        {
            if itemHeading >= 0
            {
                positionX = -(headingMultiplied - itemHeading)
            }
            else
            {
                positionX = -(headingMultiplied - itemHeading)
            }
        }
        else
        {
            positionX = itemHeading - headingMultiplied
        }
        
        positionY = verticalMultiplied
       
        let position:MetalPosition = MetalPosition(
            positionX:positionX,
            positionY:positionY)
        
        return position
    }
}
