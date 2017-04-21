import Foundation
import CoreData

extension DUser
{
    private static let kInitialValue:Int16 = 1
    
    //MARK: public
    
    func defaultValues()
    {
        level = DUser.kInitialValue
        memory = DUser.kInitialValue
        network = DUser.kInitialValue
        processor = DUser.kInitialValue
        skill = DUser.kInitialValue
    }
}
