import UIKit
import CoreLocation

class MGridMapDetail
{
    let items:[MGridMapDetailItem]
    let image:UIImage?
    
    init(
        userLocation:CLLocation,
        annotation:MGridMapAnnotation)
    {
        var items:[MGridMapDetailItem] = []
        
        if let itemTitle:MGridMapDetailItemTitle = MGridMapDetailItemTitle(annotation:annotation)
        {
            items.append(itemTitle)
        }
        
        if let itemLevel:MGridMapDetailItemLevel = MGridMapDetailItemLevel(annotation:annotation)
        {
            items.append(itemLevel)
        }
        
        if let itemDistance:MGridMapDetailItemDistance = MGridMapDetailItemDistance(
            userLocation:userLocation,
            annotation:annotation)
        {
            items.append(itemDistance)
        }
        
        if let itemAge:MGridMapDetailItemAge = MGridMapDetailItemAge(annotation:annotation)
        {
            items.append(itemAge)
        }
        
        self.items = items
        image = annotation.algo.imageDetail()
    }
}
