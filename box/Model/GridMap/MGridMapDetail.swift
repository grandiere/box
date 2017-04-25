import Foundation
import CoreLocation

class MGridMapDetail
{
    let items:[MGridMapDetailItem]
    
    init(
        userLocation:CLLocationCoordinate2D,
        annotation:MGridMapAnnotation)
    {
        var items:[MGridMapDetailItem] = []
        
        if let itemTitle:MGridMapDetailItemTitle = MGridMapDetailItemTitle(annotation:annotation)
        {
            items.append(itemTitle)
        }
        
        self.items = items
    }
}
