import Foundation

class MStorePurchaseNetwork:MStoreItem
{
    private let kStorePurchaseId:String = "iturbide.box.network"
    
    init()
    {
        let title:String = NSLocalizedString("MStorePurchaseNetwork_title", comment:"")
        let descr:String = NSLocalizedString("MStorePurchaseNetwork_descr", comment:"")
        
        super.init(
            purchaseId:kStorePurchaseId,
            title:title,
            descr:descr)
    }
    
    override func purchaseAction()
    {
        MSession.sharedInstance.settings?.user?.addNetwork()
    }
    
    override func buyingError() -> String?
    {
        guard
            
            let network:Int16 = MSession.sharedInstance.settings?.user?.network
            
        else
        {
            return nil
        }
        
        if network >= DUser.kMaxStats
        {
            let error:String = NSLocalizedString("MStorePurchaseNetwork_buyingError", comment:"")
            
            return error
        }
        else
        {
            return nil
        }
    }
}
