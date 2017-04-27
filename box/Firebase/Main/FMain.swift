import Foundation
import Firebase

class FMain
{
    static let sharedInstance:FMain = FMain()
    let analytics:FAnalytics
    let database:FDatabase
    
    private init()
    {
        FIRApp.configure()
        analytics = FAnalytics()
        database = FDatabase()
    }
    
    //MARK: public
    
    func load()
    {
    }
}
