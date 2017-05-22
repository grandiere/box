import Foundation

class MGridHarvest
{
    private(set) var items:[MGridAlgoItemHostileVirusFriendly]
    private(set) var harvestScore:Int
    private(set) var harvestKills:Int
    private weak var controller:CGridHarvest?
    private weak var modelAlgo:MGridAlgo?

    init()
    {
        items = []
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
        items = []
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.controller?.harvestLoaded()
        }
    }
    
    private func harvestLoaded(harvestItem:FDbHarvestItem)
    {
        harvestScore = harvestItem.score
        harvestKills = harvestItem.kills
     
        filterVirus()
    }
    
    private func filterVirus()
    {
        guard
        
            let modelAlgo:MGridAlgo = self.modelAlgo
        
        else
        {
            return
        }
        
        var items:[MGridAlgoItemHostileVirusFriendly] = []
        
        for item:MGridAlgoItem in modelAlgo.items
        {
            guard
            
                let itemVirusFriendly:MGridAlgoItemHostileVirusFriendly = item as? MGridAlgoItemHostileVirusFriendly
                
            else
            {
                continue
            }
            
            items.append(itemVirusFriendly)
        }
        
        items.sort
        { (virusA, virusB) -> Bool in
            
            return virusA.created > virusB.created
        }
        
        self.items = items
        
        virusFiltered()
    }
    
    private func virusFiltered()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.controller?.harvestLoaded()
        }
    }
    
    //MARK: public
    
    func loadHarvest(
        controller:CGridHarvest,
        modelAlgo:MGridAlgo)
    {
        self.controller = controller
        self.modelAlgo = modelAlgo
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.ascynLoadHarvest()
        }
    }
}
