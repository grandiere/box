import UIKit
import StoreKit

class CStore:CController, SKProductsRequestDelegate, SKPaymentTransactionObserver, SKRequestDelegate
{
    private weak var viewStore:VStore!
    private weak var request:SKProductsRequest?
    let model:MStore
    
    override init()
    {
        model = MStore()
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        request?.cancel()
        SKPaymentQueue.default().remove(self)
    }
    
    override func loadView()
    {
        let viewStore:VStore = VStore(controller:self)
        self.viewStore = viewStore
        view = viewStore
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        SKPaymentQueue.default().add(self)
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            guard
                
                let purchaseIds:[String] = self?.model.references
                
            else
            {
                return
            }
            
            let purchases:Set<String> = Set<String>(purchaseIds)
            self?.checkAvailabilities(purchases:purchases)
        }
    }
    
    //MARK: private
    
    private func checkAvailabilities(purchases:Set<String>)
    {
        let request:SKProductsRequest = SKProductsRequest(productIdentifiers:purchases)
        self.request = request
        request.delegate = self
        request.start()
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func restorePurchases()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            SKPaymentQueue.default().restoreCompletedTransactions()
        }
    }
    
    func purchase(skProduct:SKProduct?)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            guard
                
                let skProduct:SKProduct = skProduct
                
            else
            {
                return
            }
            
            let skPayment:SKPayment = SKPayment(product:skProduct)
            SKPaymentQueue.default().add(skPayment)
        }
    }
    
    //MARK: storeKit delegate
    
    func request(_ request:SKRequest, didFailWithError error:Error)
    {
        model.error = error.localizedDescription
        viewStore.refreshStore()
    }
    
    func productsRequest(_ request:SKProductsRequest, didReceive response:SKProductsResponse)
    {
        let products:[SKProduct] = response.products
        
        for product:SKProduct in products
        {
            model.loadSkProduct(skProduct:product)
        }
        
        viewStore.refreshStore()
    }
    
    func paymentQueue(_ queue:SKPaymentQueue, updatedTransactions transactions:[SKPaymentTransaction])
    {
        model.updateTransactions(transactions:transactions)
        viewStore.refreshStore()
    }
    
    func paymentQueue(_ queue:SKPaymentQueue, removedTransactions transactions:[SKPaymentTransaction])
    {
        model.updateTransactions(transactions:transactions)
        viewStore.refreshStore()
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue:SKPaymentQueue)
    {
        viewStore.refreshStore()
    }
    
    func paymentQueue(_ queue:SKPaymentQueue, restoreCompletedTransactionsFailedWithError error:Error)
    {
        model.error = error.localizedDescription
        viewStore.refreshStore()
    }
}
