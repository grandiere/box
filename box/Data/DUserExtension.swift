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
    
    func addMemory()
    {
        memory += DUser.kInitialValue
        
        if memory > DUser.kMaxStats
        {
            memory = DUser.kMaxStats
        }
    }
    
    func addNetwork()
    {
        network += DUser.kInitialValue
        
        if network > DUser.kMaxStats
        {
            network = DUser.kMaxStats
        }
    }
    
    func addProcessor()
    {
        processor += DUser.kInitialValue
        
        if processor > DUser.kMaxStats
        {
            processor = DUser.kMaxStats
        }
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
