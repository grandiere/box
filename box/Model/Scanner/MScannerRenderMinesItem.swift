import Foundation
import CoreLocation

class MScannerRenderMinesItem
{
    let mineHeading:Float
    let location:CLLocation
    
    init(location:CLLocation, mineHeading:Float)
    {
        self.location = location
        self.mineHeading = mineHeading
    }
}
