import UIKit
import MetalKit
import CoreLocation

class MScannerRenderMinesItem
{
    let originalHeading:Double
    let location:CLLocation
    let position:MetalPosition
    private let kHeadingMultiplier:Float = 6
    
    init(location:CLLocation)
    {
        self.location = location
        originalHeading = 0
        position = MetalPosition.zero()
    }
    
    //MARK: public
    
    func positionBuffer(
        device:MTLDevice,
        heading:Double) -> MTLBuffer
    {
        position.positionX = Float(originalHeading - heading) * kHeadingMultiplier
        let positionBuffer:MTLBuffer = device.generateBuffer(bufferable:position)
        
        return positionBuffer
    }
}
