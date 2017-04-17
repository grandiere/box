import Foundation
import CoreLocation

class MGridAlgo
{
    private(set) var items:[MGridAlgoItem]
    private(set) var nearItems:[MGridAlgoItem]?
    private let kMaxDistance:CLLocationDistance = 300
    
    init()
    {
        items = []
    }
    
    //MARK: public
    
    func clearNearItems()
    {
        nearItems = nil
    }
    
    func loadAlgo()
    {
        let itemDefault:MGridAlgoItemHostileBug = MGridAlgoItemHostileBug(
            latitude:19.410595057002922,
            longitude:-99.175156495306979,
            difficulty:1,
            created:1)
        
        items.append(itemDefault)
    }
    
    func filterNearItems(userLocation:CLLocation)
    {
        var nearItems:[MGridAlgoItem] = []
        
        for item:MGridAlgoItem in items
        {
            item.distanceUser(userLocation:userLocation)
            
            guard
            
                let itemDistance:CLLocationDistance = item.distance
            
            else
            {
                continue
            }
            
            if itemDistance < kMaxDistance
            {
                nearItems.append(item)
            }
        }
        
        self.nearItems = nearItems
    }
}
