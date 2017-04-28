import Foundation

class FDatabaseNodeAlgoItemHostile:FDatabaseNodeAlgoItem
{
    override func json() -> Any
    {
        var json:[String:Any] = [
            FDatabaseNodeAlgoItem.latitude:latitude,
            FDatabaseNodeAlgoItem.longitude:longitude,
            FDatabaseNodeAlgoItem.created:created]
        
        if let superJson:[String:Any] = super.json() as? [String:Any]
        {
            json = json.merge(other:superJson)
        }
        
        return json
    }
}
