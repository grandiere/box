import Foundation

class MScannerOrientationPortrait:MScannerOrientation
{
    override func itemPosition(
        userHeading:Float,
        moveVertical:Float,
        itemHeading:Float) -> MetalPosition?
    {
        let normalUserHeading:Float = normalHeading(rawHeading:userHeading)
        let verticalMultiplied:Float = moveVertical * kVerticalMultiplier
        let positionX:Float = itemHeading - normalUserHeading
        let positionY:Float = verticalMultiplied
        
        let position:MetalPosition = MetalPosition(
            positionX:positionX,
            positionY:positionY)
        
        return position
    }
}
