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
        MSession.sharedInstance.settings?.user?.addMemory()
    }
    
    override func buyingError() -> String?
    {
        guard
            
            let memory:Int16 = MSession.sharedInstance.settings?.user?.memory
            
        else
        {
            return nil
        }
        
        if memory >= DUser.kMaxStats
        {
            let error:String = NSLocalizedString("MStorePurchaseMemory_buyingError", comment:"")
            
            return error
        }
        else
        {
            return nil
        }
    }
}
