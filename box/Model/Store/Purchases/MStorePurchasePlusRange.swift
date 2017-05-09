import Foundation

class MStorePurchasePlusRange:MStoreItem
{
    private let kStorePurchaseId:String = "iturbide.box.plusRange"
    
    init()
    {
        let title:String = NSLocalizedString("MStorePurchasePlusRange_title", comment:"")
        let descr:String = NSLocalizedString("MStorePurchasePlusRange_descr", comment:"")
        
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
    
    override func validatePurchase() -> Bool
    {
        guard
            
            let purchased:Bool = MSession.sharedInstance.settings?.plusRange
            
        else
        {
            return false
        }
        
        return purchased
    }
}
