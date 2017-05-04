import Foundation
import CoreData

extension DUser
{
    private static let kInitialValue:Int16 = 1
    private static let kMaxStats:Int16 = 10
    
    //MARK: public
    
    func defaultValues()
    {
        level = DUser.kInitialValue
        memory = DUser.kInitialValue
        network = DUser.kInitialValue
        processor = DUser.kInitialValue
        skill = DUser.kInitialValue
    }
    
    func addSkill()
    {
        skill += DUser.kInitialValue
        
        if skill > DUser.kMaxStats
        {
            skill = DUser.kMaxStats
        }
    }
}
