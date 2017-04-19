import UIKit
import CoreLocation

class MGridAlgoItem
{
    let location:CLLocation
    private(set) var distance:CLLocationDistance?
    private(set) var heading:Float
    var multipliedHeading:Float
    
    init(
        latitude:Double,
        longitude:Double)
    {
        location = CLLocation(latitude:latitude, longitude:longitude)
        heading = 0
        multipliedHeading = 0
    }
    
    //MARK: public
    
    final func distanceUser(userLocation:CLLocation)
    {
        distance = location.distance(from:userLocation)
    }
    
    func imageStandby() -> UIImage?
    {
        return nil
    }
    
    func imageTargeted() -> UIImage?
    {
        return nil
    }
    
    func imageDetail() -> UIImage?
    {
        return nil
    }
    
    func detail() -> MGridVisorDetail
    {
        let model:MGridVisorDetail = MGridVisorDetail()
        
        return model
    }
}
