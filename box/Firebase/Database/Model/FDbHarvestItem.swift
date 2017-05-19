import Foundation

class FDbHarvestItem:FDbProtocol
{
    static let score:String = "score"
    static let kills:String = "kills"
    
    let score:Int
    let kills:Int
    private let kDefault:Int = 0
    
    init()
    {
        score = kDefault
        kills = kDefault
    }
    
    //MARK: node protocol
    
    required init?(snapshot:Any)
    {
        let snapshotDict:[String:Any]? = snapshot as? [String:Any]
        
        if let score:Int = snapshotDict?[
            FDbHarvestItem.score] as? Int
        {
            self.score = score
        }
        else
        {
            score = kDefault
        }
        
        if let kills:Int = snapshotDict?[
            FDbHarvestItem.kills] as? Int
        {
            self.kills = kills
        }
        else
        {
            kills = kDefault
        }
    }
    
    func json() -> Any?
    {
        let json:[String:Any] = [
            FDbHarvestItem.score:score,
            FDbHarvestItem.kills:kills]
        
        return json
    }
}
