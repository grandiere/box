import UIKit
import MetalKit
import CoreLocation

class MScannerRenderMinesItem
{
    let location:CLLocation
    let positionBuffer:MTLBuffer
    
    init(
        device:MTLDevice,
        location:CLLocation)
    {
        self.location = location
        let position:MetalPosition = MetalPosition.zero()
        positionBuffer = device.generateBuffer(bufferable:position)
    }
}
