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
    
    //MARK: private
    
    private func loadFirebaseBugs(userLocation:CLLocation)
    {
        FMain.sharedInstance.db.listenOnce(
            path:FDb.algoBug,
            nodeType:FDbAlgoHostileBug.self)
        { (node:FDbProtocol?) in
            
        }
    }
    
    //MARK: public
    
    func loadAlgo(
        userLocation:CLLocation,
        controller:CGrid)
    {
        self.controller = controller
        nearItems = nil
        items = []
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.loadFirebaseBugs(userLocation:userLocation)
        }
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
