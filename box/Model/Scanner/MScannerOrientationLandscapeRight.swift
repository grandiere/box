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
        
        positionY = 0
        positionX = 0
        
        /*
 
 
         if userHeading >= 0
         {
         positionY = -(headingMultiplied + mineHeading)
         }
         else
         {
         positionY = mineHeading - headingMultiplied
         }
         
         
         positionX = 0
         
 */
        
        let position:MetalPosition = MetalPosition(
            positionX:positionX,
            positionY:positionY)
        
        return position
    }
}
