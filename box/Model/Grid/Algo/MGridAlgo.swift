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
    
    private func filterNear(
        fromItems:[MGridAlgoItem],
        location:CLLocation,
        renderReady:Bool) -> [MGridAlgoItem]
    {
        var near:[MGridAlgoItem] = []
        
        for item:MGridAlgoItem in items
        {
            item.distanceTo(
                location:location,
                renderReady:renderReady)
            
            guard
                
                let itemDistance:CLLocationDistance = item.distance
                
            else
            {
                continue
            }
            
            if itemDistance < MGridAlgo.kMaxDistance
            {
                near.append(item)
            }
        }
        
        return near
    }
    
    private func loadFirebaseBugs(userLocation:CLLocation)
    {
        FMain.sharedInstance.db.listenOnce(
            path:FDb.algoBug,
            nodeType:FDbAlgoHostileBug.self)
        { [weak self] (node:FDbProtocol?) in
            
            var items:[MGridAlgoItemHostileBug] = []
            
            if let bugs:FDbAlgoHostileBug = node as? FDbAlgoHostileBug
            {
                let bugIds:[String] = Array(bugs.items.keys)
                
                for bugId:String in bugIds
                {
                    guard
                        
                        let bug:FDbAlgoHostileBugItem = bugs.items[bugId]
                        
                    else
                    {
                        continue
                    }
                    
                    let item:MGridAlgoItemHostileBug = MGridAlgoItemHostileBug(
                        firebaseId:bugId,
                        latitude:bug.latitude,
                        longitude:bug.longitude,
                        level:bug.level,
                        created:bug.created)
                    
                    items.append(item)
                }
            }
            
            self?.firebaseBugsLoaded(items:items)
        }
    }
    
    private func firebaseBugsLoaded(items:[MGridAlgoItemHostileBug])
    {
        
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
        nearItems = filterNear(
            fromItems:items,
            location:userLocation,
            renderReady:true)
    }
}
