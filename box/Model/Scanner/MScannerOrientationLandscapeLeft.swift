import Foundation

class MScannerOrientationLandscapeLeft:MScannerOrientation
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
            let inversedHeading:Float = k360Deg - userHeading
            let headingMultiplied:Float  = inversedHeading * MScannerOrientation.kHorizontalMultiplier
            positionY = -(headingMultiplied + itemHeading)
        }
        else
        {
            let headingMultiplied:Float = userHeading * MScannerOrientation.kHorizontalMultiplier
            positionY = -(itemHeading - headingMultiplied)
        }
        
        positionX = moveVertical
        
        let position:MetalPosition = MetalPosition(
            positionX:positionX,
            positionY:positionY)
        
        return position
    }
}
