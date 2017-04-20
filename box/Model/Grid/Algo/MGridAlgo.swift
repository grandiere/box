import Foundation
import CoreLocation

class MGridAlgo
{
    static let kMaxDistance:CLLocationDistance = 0.5
    private(set) var items:[MGridAlgoItem]
    private(set) var nearItems:[MGridAlgoItem]?
    
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
            
            if itemDistance < MGridAlgo.kMaxDistance
            {
                nearItems.append(item)
            }
        }
        
        self.nearItems = nearItems
    }
}
