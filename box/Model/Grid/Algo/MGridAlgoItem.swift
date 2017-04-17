import UIKit
import CoreLocation

class MGridAlgoItem
{
    let location:CLLocation
    let image:UIImage
    private(set) var distance:CLLocationDistance?
    private(set) var heading:Float
    
    init(
        latitude:Double,
        longitude:Double,
        image:UIImage)
    {
        self.image = image
        location = CLLocation(latitude:latitude, longitude:longitude)
        heading = 0
    }
    
    //MARK: public
    
    final func distanceUser(userLocation:CLLocation)
    {
        distance = location.distance(from:userLocation)
    }
}
