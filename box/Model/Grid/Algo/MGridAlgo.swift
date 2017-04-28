import Foundation
import CoreLocation

class MGridAlgo
{
    private weak var controller:CGrid?
    static let kMaxDistance:CLLocationDistance = 1000
    private(set) var items:[MGridAlgoItem]
    private(set) var nearItems:[MGridAlgoItem]?
    
    init()
    {
        items = []
    }
    
    //MARK: public
    
    func loadAlgo(controller:CGrid)
    {
        self.controller = controller
        nearItems = nil
        items = []
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
