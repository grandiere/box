import Foundation
import CoreData

extension DEnergy
{
    static let kMaxEnergy:Int16 = 100
    
    //MARK: public
    
    func defaultValues()
    {
        amount = DEnergy.kMaxEnergy
        lastAmount = amount
        lastDate = Date().timeIntervalSince1970
    }
}
