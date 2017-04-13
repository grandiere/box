import UIKit
import MetalKit
import CoreLocation

class MScannerRenderMinesItem
{
    let originalHeading:Float
    let location:CLLocation
    let position:MetalPosition
    private let kMultiplier:Float = 10
    
    init(location:CLLocation)
    {
        self.location = location
        originalHeading = -900
        position = MetalPosition.zero()
    }
    
    //MARK: public
    
    func positionBuffer(
        device:MTLDevice,
        userHeading:Float,
        verticalAlign:Float) -> MTLBuffer
    {
        position.positionX = originalHeading - (userHeading * kMultiplier)
        position.positionY = verticalAlign * kMultiplier
        let positionBuffer:MTLBuffer = device.generateBuffer(bufferable:position)
        
        return positionBuffer
    }
}
