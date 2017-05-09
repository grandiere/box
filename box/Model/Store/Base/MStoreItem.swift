import Foundation
import StoreKit

class MStoreItem
{
    let purchaseId:String
    let title:String
    let descr:String
    var skProduct:SKProduct?
    private(set) var price:String?
    private(set) var status:MStoreStatusProtocol?
    
    init(
        purchaseId:String,
        title:String,
        descr:String)
    {
        self.purchaseId = purchaseId
        self.title = title
        self.descr = descr
        status = MStoreStatusNotAvailable()
    }
    
    //MARK: public
    
    func purchaseAction()
    {
    }
    
    func buyingError() -> String?
    {
        return nil
    }
    
    func validatePurchase() -> Bool
    {
        return false
    }
    
    //MARK: final
    
    final func foundPurchase(price:String)
    {
        self.price = price
        
        let isPurchased:Bool = validatePurchase()
        
        if isPurchased
        {
            statusPurchased(callAction:false)
        }
        else
        {
            statusNew()
        }
    }
    
    final func statusNew()
    {
        status = MStoreStatusNew()
    }
    
    final func statusDeferred()
    {
        status = MStoreStatusDeferred()
    }
    
    final func statusPurchasing()
    {
        status = MStoreStatusPurchasing()
    }
    
    final func statusPurchased(callAction:Bool)
    {
        status = MStoreStatusPurchased()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            if callAction
            {
                self?.purchaseAction()
            }
        }
    }
}
