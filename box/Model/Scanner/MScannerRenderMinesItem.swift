import UIKit
import MetalKit
import CoreLocation

class MScannerRenderMinesItem
{
    let location:CLLocation
    let position:MetalPosition
    
    init(location:CLLocation)
    {
        self.location = location
        position = MetalPosition.zero()
    }
    
    //MARK: public
    
    func positionBuffer(device:MTLDevice) -> MTLBuffer
    {
        let positionBuffer:MTLBuffer = device.generateBuffer(bufferable:position)
        
        return positionBuffer
    }
}
