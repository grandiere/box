import Foundation

class MStorePurchaseSkill:MStoreItem
{
    private let kStorePurchaseId:String = "iturbide.box.skill"
    
    init()
    {
        let title:String = NSLocalizedString("MStorePurchaseSkill_title", comment:"")
        let descr:String = NSLocalizedString("MStorePurchaseSkill_descr", comment:"")
        
        super.init(
            purchaseId:kStorePurchaseId,
            title:title,
            descr:descr)
    }
    
    override func purchaseAction()
    {
        MSession.sharedInstance.settings?.user?.addSkill()
    }
    
    override func buyingError() -> String?
    {
        guard
            
            let skill:Int16 = MSession.sharedInstance.settings?.user?.skill
            
        else
        {
            return nil
        }
        
        if skill >= DUser.kMaxStats
        {
            let error:String = NSLocalizedString("MStorePurchaseSkill_buyingError", comment:"")
            
            return error
        }
        else
        {
            return nil
        }
    }
}
