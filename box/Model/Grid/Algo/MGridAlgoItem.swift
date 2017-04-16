import Foundation
import CoreLocation

class MGridAlgoItem
{
    let location:CLLocation
    
    init(
        latitude:Double,
        longitude:Double)
    {
        location = CLLocation(latitude:latitude, longitude:longitude)
    }
}
