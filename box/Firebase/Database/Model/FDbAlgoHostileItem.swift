import Foundation

class FDbAlgoHostileItem:FDbAlgoItem
{
    static let level:String = "level"
    static let defeated:String = "defeated"
    
    let level:Int
    let defeated:Int
    private let kInitialDefeated:Int = 0
    
    init(
        latitude:Double,
        longitude:Double,
        created:TimeInterval,
        level:Int)
    {
        self.level = level
        defeated = kInitialDefeated
        
        super.init(
            latitude:latitude,
            longitude:longitude,
            created:created)
    }
    
    required init?(snapshot:Any)
    {
        guard
            
            let snapshotDict:[String:Any] = snapshot as? [String:Any],
            let level:Int = snapshotDict[FDbAlgoHostileItem.level] as? Int
            
        else
        {
            return nil
        }
        
        self.level = level
        
        if let defeated:Int = snapshotDict[
            FDbAlgoHostileItem.defeated] as? Int
        {
            self.defeated = defeated
        }
        else
        {
            defeated = kInitialDefeated
        }
        
        super.init(snapshot:snapshot)
    }
    
    override func json() -> Any?
    {
        var json:[String:Any] = [
            FDbAlgoHostileItem.level:level,
            FDbAlgoHostileItem.defeated:defeated]
        
        if let superJson:[String:Any] = super.json() as? [String:Any]
        {
            json = json.merge(other:superJson)
        }
        
        return json
    }
}
