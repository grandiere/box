import Foundation
import CoreLocation

class MGridAlgo
{
    static let kMaxDistance:CLLocationDistance = 5
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
        let parkSpain:MGridAlgoItemHostileBug = MGridAlgoItemHostileBug(
            latitude:19.414791,
            longitude:-99.171507,
            difficulty:2,
            created:2)
        let mexicali:MGridAlgoItemHostileBug = MGridAlgoItemHostileBug(
            latitude:19.408238,
            longitude:-99.173356,
            difficulty:3,
            created:3)
        let amatlan:MGridAlgoItemHostileBug = MGridAlgoItemHostileBug(
            latitude:19.410172,
            longitude:-99.176893,
            difficulty:4,
            created:4)
        
        items.append(itemDefault)
        items.append(parkSpain)
        items.append(mexicali)
        items.append(amatlan)
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
