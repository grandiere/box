import Foundation

class FDbAlgoHostileItem:FDbAlgoItem
{
    static let level:String = "level"
    
    let level:Int
    
    init(
        latitude:Double,
        longitude:Double,
        created:TimeInterval,
        level:Int)
    {
        self.level = level
        
        super.init(
            latitude:latitude,
            longitude:longitude,
            created:created)
    }
    
    required init?(snapshot:Any)
    {
        guard
            
            let snapshotDict:[String:Any] = snapshot as? [String:Any],
            let level:Int = snapshotDict[FDatabaseNodeAlgoItemHostile.level] as? Int
            
        else
        {
            return nil
        }
        
        self.level = level
        
        super.init(snapshot:snapshot)
    }
    
    override func json() -> Any
    {
        var json:[String:Any] = [
            FDatabaseNodeAlgoItemHostile.level:level]
        
        if let superJson:[String:Any] = super.json() as? [String:Any]
        {
            json = json.merge(other:superJson)
        }
        
        return json
    }
}
