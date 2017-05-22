import Foundation

class MGridHarvest
{
    private(set) var harvestScore:Int
    private(set) var harvestKills:Int
    private weak var controller:CGridHarvest?

    init()
    {
        harvestScore = 0
        harvestKills = 0
    }
    
    //MARK: private
    
    private func ascynLoadHarvest()
    {
        guard
            
            let userId:String = MSession.sharedInstance.settings?.firebaseId
            
        else
        {
            self.harvestNotLoaded()
            
            return
        }
        
        let path:String = "\(FDb.harvest)/\(userId)/"
        
        FMain.sharedInstance.db.listenOnce(
            path:path,
            nodeType:FDbHarvestItem.self)
        { [weak self] (data:FDbProtocol?) in
            
            guard
                
                let harvestItem:FDbHarvestItem = data as? FDbHarvestItem
                
            else
            {
                self?.harvestNotLoaded()
                
                return
            }
            
            self?.harvestLoaded(harvestItem:harvestItem)
        }
    }
    
    private func harvestNotLoaded()
    {
        harvestScore = 0
        harvestKills = 0
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.controller?.viewHarvest.viewBar.viewCollect.displayHarvest()
        }
    }
    
    private func harvestLoaded(harvestItem:FDbHarvestItem)
    {
        harvestScore = harvestItem.score
        harvestKills = harvestItem.kills
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.controller?.viewHarvest.viewBar.viewCollect.displayHarvest()
        }
    }
    
    //MARK: public
    
    func loadHarvest(controller:CGridHarvest)
    {
        self.controller = controller
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.ascynLoadHarvest()
        }
    }
}
