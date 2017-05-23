import Foundation
import Firebase

class FMain
{
    static let sharedInstance:FMain = FMain()
    let analytics:FAnalytics
    let db:FDb
    
    private init()
    {
        FirebaseApp.configure()
        analytics = FAnalytics()
        db = FDb()
    }
    
    //MARK: public
    
    func load()
    {
    }
}
