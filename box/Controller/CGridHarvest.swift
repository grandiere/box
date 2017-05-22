import UIKit

class CGridHarvest:CController
{
    private weak var viewHarvest:VGridHarvest!
    
    override func loadView()
    {
        let viewHarvest:VGridHarvest = VGridHarvest(controller:self)
        self.viewHarvest = viewHarvest
        view = viewHarvest
    }
    
    //MARK: private
    
    private func asyncLoadHarvest()
    {
        guard
            
            let userId:String = MSession.sharedInstance.settings?.firebaseId
        
        else
        {
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
                return
            }
            
            
        }
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func loadHarvest()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncLoadHarvest()
        }
    }
}
