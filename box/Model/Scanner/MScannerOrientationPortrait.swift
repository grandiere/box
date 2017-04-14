import Foundation
import MetalKit

class MScannerOrientationPortrait:MScannerOrientation
{
    override func positionBuffer(
        device:MTLDevice,
        userHeading:Float,
        moveVertical:Float,
        itemHeading:Float) -> MTLBuffer?
    {
        let headingMultiplied:Float = userHeading * MScannerOrientation.kHorizontalMultiplier
        let verticalMultiplied:Float = moveVertical * MScannerOrientation.kVerticalMultiplier
        let positionX:Float
        let positionY:Float
        
        if userHeading >= 0
        {
            positionX = -(headingMultiplied + itemHeading)
        }
        else
        {
            positionX = itemHeading - headingMultiplied
        }
        
        positionY = verticalMultiplied
       
        let position:MetalPosition = MetalPosition(
            positionX:positionX,
            positionY:positionY)
        let buffer:MTLBuffer = device.generateBuffer(
            bufferable:position)
        
        return buffer
    }
}
