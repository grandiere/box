import Foundation
import CoreData

extension DUser
{
    private static let kInitialValue:Int16 = 1
    static let kMaxStats:Int16 = 10
    
    //MARK: public
    
    func defaultValues()
    {
        level = DUser.kInitialValue
        memory = DUser.kInitialValue
        network = DUser.kInitialValue
        processor = DUser.kInitialValue
        skill = DUser.kInitialValue
    }
    
    func addLevel()
    {
        level += DUser.kInitialValue
        
        if level > DUser.kMaxStats
        {
            level = DUser.kMaxStats
        }
        
        DManager.sharedInstance?.save()
    }
    
    func addMemory()
    {
        memory += DUser.kInitialValue
        
        if memory > DUser.kMaxStats
        {
            memory = DUser.kMaxStats
        }
        
        DManager.sharedInstance?.save()
    }
    
    func addNetwork()
    {
        network += DUser.kInitialValue
        
        if network > DUser.kMaxStats
        {
            network = DUser.kMaxStats
        }
        
        DManager.sharedInstance?.save()
    }
    
    func addProcessor()
    {
        processor += DUser.kInitialValue
        
        if processor > DUser.kMaxStats
        {
            processor = DUser.kMaxStats
        }
        
        DManager.sharedInstance?.save()
    }
    
    func addSkill()
    {
        skill += DUser.kInitialValue
        
        if skill > DUser.kMaxStats
        {
            skill = DUser.kMaxStats
        }
        
        DManager.sharedInstance?.save()
    }
}
