import Foundation

class FDbUserItem:FDbProtocol
{
    static let handler:String = "handler"
    static let level:String = "level"
    static let score:String = "score"
    static let kills:String = "kills"
    static let created:String = "created"
    static let active:String = "active"
    
    let handler:String?
    let level:Int
    let score:Int
    let kills:Int
    let created:TimeInterval
    let active:Bool
    private let kActive:Bool = true
    private let kNotActive:Bool = false
    private let kInitialLevel:Int = 1
    private let kInitialScore:Int = 0
    private let kInitialKills:Int = 0
    private let kNoTime:TimeInterval = 0
    
    init()
    {
        handler = nil
        level = kInitialLevel
        score = kInitialScore
        kills = kInitialKills
        created = NSDate().timeIntervalSince1970
        active = kActive
    }
    
    //MARK: node protocol
    
    required init?(snapshot:Any)
    {
        let snapshotDict:[String:Any]? = snapshot as? [String:Any]
        handler = snapshotDict?[FDbUserItem.handler] as? String
        
        if let level:Int = snapshotDict?[
            FDbUserItem.level] as? Int
        {
            self.level = level
        }
        else
        {
            level = kInitialLevel
        }
        
        if let score:Int = snapshotDict?[
            FDbUserItem.score] as? Int
        {
            self.score = score
        }
        else
        {
            score = kInitialScore
        }
        
        if let kills:Int = snapshotDict?[
            FDbUserItem.kills] as? Int
        {
            self.kills = kills
        }
        else
        {
            kills = kInitialKills
        }
        
        if let created:TimeInterval = snapshotDict?[
            FDbUserItem.created] as? TimeInterval
        {
            self.created = created
        }
        else
        {
            created = kNoTime
        }
        
        if let active:Bool = snapshotDict?[
            FDbUserItem.active] as? Bool
        {
            self.active = active
        }
        else
        {
            active = kNotActive
        }
    }
    
    func json() -> Any?
    {
        var json:[String:Any] = [
            FDbUserItem.level:level,
            FDbUserItem.score:score,
            FDbUserItem.kills:kills,
            FDbUserItem.created:created,
            FDbUserItem.active:active]
        
        if let handler:String = handler
        {
            json[FDbUserItem.handler] = handler
        }
        
        return json
    }
}
