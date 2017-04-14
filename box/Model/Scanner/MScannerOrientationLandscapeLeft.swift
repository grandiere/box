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
            let inversedItemHeading:Float = k360Deg - itemHeading
            let headingMultiplied:Float  = inversedItemHeading * MScannerOrientation.kHorizontalMultiplier
            positionY = -(headingMultiplied + itemHeading)
        }
        else
        {
            let headingMultiplied:Float = itemHeading * MScannerOrientation.kHorizontalMultiplier
            positionY = -(itemHeading - headingMultiplied)
        }
        
        positionX = 0
        
        let position:MetalPosition = MetalPosition(
            positionX:positionX,
            positionY:positionY)
        
        return position
    }
}
