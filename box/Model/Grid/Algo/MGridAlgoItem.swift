import UIKit
import CoreLocation

class MGridAlgoItem
{
    let location:CLLocation
    let image:UIImage
    let width:Float
    let height:Float
    private(set) var distance:CLLocationDistance?
    private(set) var heading:Float
    var multipliedHeading:Float
    
    init(
        latitude:Double,
        longitude:Double,
        image:UIImage,
        width:Float,
        height:Float)
    {
        self.image = image
        self.width = width
        self.height = height
        location = CLLocation(latitude:latitude, longitude:longitude)
        heading = 0
        multipliedHeading = 0
    }
    
    //MARK: public
    
    final func distanceUser(userLocation:CLLocation)
    {
        distance = location.distance(from:userLocation)
    }
}
