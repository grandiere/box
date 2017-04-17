import Foundation
import CoreLocation

class MGridAlgoItem
{
    let location:CLLocation
    private(set) var distance:CLLocationDistance?
    
    init(
        latitude:Double,
        longitude:Double)
    {
        location = CLLocation(latitude:latitude, longitude:longitude)
    }
    
    //MARK: public
    
    final func distanceUser(userLocation:CLLocation)
    {
        distance = location.distance(from:userLocation)
    }
}
