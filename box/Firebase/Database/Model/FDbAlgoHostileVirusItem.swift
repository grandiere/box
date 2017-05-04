import Foundation

class FDbAlgoHostileVirusItem:FDbAlgoHostileItem
{
    static let userId:String = "user_id"
    
    let userId:String
    
    init(
        latitude:Double,
        longitude:Double,
        created:TimeInterval,
        level:Int,
        userId:String)
    {
        self.userId = userId
        
        super.init(
            latitude:latitude,
            longitude:longitude,
            created:created,
            level:level)
    }
    
    required init?(snapshot:Any)
    {
        guard
            
            let snapshotDict:[String:Any] = snapshot as? [String:Any],
            let userId:String = snapshotDict[FDbAlgoHostileVirusItem.userId] as? String
            
        else
        {
            return nil
        }
        
        self.userId = userId
        
        super.init(snapshot:snapshot)
    }
    
    override func json() -> Any?
    {
        var json:[String:Any] = [
            FDbAlgoHostileVirusItem.userId:userId]
        
        if let superJson:[String:Any] = super.json() as? [String:Any]
        {
            json = json.merge(other:superJson)
        }
        
        return json
    }
}
