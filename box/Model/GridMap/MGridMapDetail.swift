import Foundation
import CoreLocation

class MGridMapDetail
{
    let items:[MGridMapDetailItem]
    
    init(
        userLocation:CLLocationCoordinate2D,
        annotation:MGridMapAnnotation)
    {
        items = [
        ]
    }
}
