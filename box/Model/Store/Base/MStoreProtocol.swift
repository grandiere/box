import UIKit

protocol MStoreProtocol
{
    var purchaseId:String { get }
    var title:String { get }
    var descr:String { get }
    
    func purchaseAction()
    func validatePurchase() -> Bool
}
