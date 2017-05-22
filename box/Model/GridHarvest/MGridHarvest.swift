import Foundation
import FirebaseDatabase

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
        
        filterVirus()
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
            
            return virusA.created < virusB.created
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
    
    private func finishCollecting()
    {
        let message:String = NSLocalizedString("MGridHarvest_success", comment:"")
        VAlert.messageBlue(message:message)
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.ascynLoadHarvest()
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
    
    func collect()
    {
        guard
            
            let userId:String = MSession.sharedInstance.settings?.firebaseId
        
        else
        {
            finishCollecting()
            
            return
        }
        
        let harvestScore:Int = self.harvestScore
        let harvestKills:Int = self.harvestKills
        
        let path:String = "\(FDb.harvest)/\(userId)"
        FMain.sharedInstance.db.transaction(
            path:path)
        { (mutableData:FIRMutableData) -> (FIRTransactionResult) in
            
            var newHarvestItem:FDbHarvestItem?
            
            if let currentHarvest:Any = mutableData.value
            {
                if let harvestItem:FDbHarvestItem = FDbHarvestItem(snapshot:currentHarvest)
                {
                    var newScore:Int = harvestItem.score - harvestScore
                    var newKills:Int = harvestItem.kills - harvestKills
                    
                    if newScore < 0
                    {
                        newScore = 0
                    }
                    
                    if newKills < 0
                    {
                        newKills = 0
                    }
                    
                    newHarvestItem = FDbHarvestItem(
                        score:newScore,
                        kills:newKills)
                }
            }
            
            if newHarvestItem == nil
            {
                newHarvestItem = FDbHarvestItem(
                    score:0,
                    kills:0)
            }
            
            let harvestJson:Any? = newHarvestItem?.json()
            mutableData.value = harvestJson
            
            let transactionResult:FIRTransactionResult = FIRTransactionResult.success(
                withValue:mutableData)
            
            return transactionResult
        }
        
        MSession.sharedInstance.addScore(credits:harvestScore)
        
        finishCollecting()
    }
}
