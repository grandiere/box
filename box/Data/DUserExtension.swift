import Foundation
import CoreData

extension DUser
{
    private static let kInitialValues:Int16 = 1
    
    //MARK: public
    
    func defaultValues()
    {
        amount = DEnergy.kMaxEnergy
        lastAmount = amount
        lastDate = Date().timeIntervalSince1970
    }
}
