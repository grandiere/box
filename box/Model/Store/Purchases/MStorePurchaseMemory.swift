import Foundation

class MStorePurchaseMemory:MStoreItem
{
    private let kStorePurchaseId:String = "iturbide.box.memory"
    
    init()
    {
        let title:String = NSLocalizedString("MStorePurchaseMemory_title", comment:"")
        let descr:String = NSLocalizedString("MStorePurchaseMemory_descr", comment:"")
        
        super.init(
            purchaseId:kStorePurchaseId,
            title:title,
            descr:descr)
    }
    
    override func purchaseAction()
    {
        MSession.sharedInstance.settings?.plusRange = true
        DManager.sharedInstance?.save()
    }
    
    override func buyingError() -> String?
    {
        guard
            
            let energy:Int16 = MSession.sharedInstance.settings?.energy?.amount
            
            else
        {
            return nil
        }
        
        if energy >= DEnergy.kMaxEnergy
        {
            let error:String = NSLocalizedString("MStorePurchaseEnergy_buyingError", comment:"")
            
            return error
        }
        else
        {
            return nil
        }
    }
}
