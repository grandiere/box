import Foundation

class FDatabaseNodeUserItem:FDatabaseNodeProtocol
{
    static let handler:String = "handler"
    static let score:String = "score"
    static let created:String = "created"
    static let active:String = "active"
    
    let handler:String?
    let score:Int
    let created:TimeInterval
    let active:Bool
    private let kActive:Bool = true
    private let kNotActive:Bool = false
    private let kInitialScore:Int = 0
    private let kNoTime:TimeInterval = 0
    
    init()
    {
        handler = nil
        score = kInitialScore
        created = NSDate().timeIntervalSince1970
        active = kActive
    }
    
    //MARK: node protocol
    
    required init?(snapshot:Any)
    {
        let snapshotDict:[String:Any]? = snapshot as? [String:Any]
        handler = snapshotDict?[FDatabaseNodeUserItem.handler] as? String
        
        if let score:Int = snapshotDict?[
            FDatabaseNodeUserItem.score] as? Int
        {
            self.score = score
        }
        else
        {
            score = kInitialScore
        }
        
        if let created:TimeInterval = snapshotDict?[
            FDatabaseNodeUserItem.created] as? TimeInterval
        {
            self.created = created
        }
        else
        {
            created = kNoTime
        }
        
        if let active:Bool = snapshotDict?[
            FDatabaseNodeUserItem.active] as? Bool
        {
            self.active = active
        }
        else
        {
            active = kNotActive
        }
    }
    
    func json() -> Any
    {
        var json:[String:Any] = [
            FDatabaseNodeUserItem.score:score,
            FDatabaseNodeUserItem.created:created,
            FDatabaseNodeUserItem.active:active]
        
        if let handler:String = handler
        {
            json[FDatabaseNodeUserItem.handler] = handler
        }
        
        return json
    }
}
