import Foundation

class MStorePurchaseEnergy:MStoreItem
{
    private let kStorePurchaseId:String = "iturbide.box.energy"
    
    init()
    {
        let title:String = NSLocalizedString("MStorePurchaseEnergy_title", comment:"")
        let descr:String = NSLocalizedString("MStorePurchaseEnergy_descr", comment:"")
        
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
}
