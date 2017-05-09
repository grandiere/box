import UIKit
import StoreKit

protocol MStoreProtocol
{
    var purchaseId:String { get }
    var title:String { get }
    var descr:String { get }
    var skProduct:SKProduct? { get }
    private(set) var price:String? { get }
    private(set) var status:MStoreItemStatus? { get }
    
    func purchaseAction()
    func validatePurchase() -> Bool
}
