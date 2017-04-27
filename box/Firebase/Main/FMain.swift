import Foundation
import Firebase

class FMain
{
    static let sharedInstance:FMain = FMain()
    let analytics:FAnalytics
    let database:FDatabase
    let storage:FStorage
    
    private init()
    {
        FIRApp.configure()
        analytics = FAnalytics()
        database = FDatabase()
        storage = FStorage()
    }
    
    //MARK: public
    
    func load()
    {
    }
}
