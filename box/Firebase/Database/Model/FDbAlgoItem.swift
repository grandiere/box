import Foundation

class FDbAlgoItem:FDbProtocol
{
    static let latitude:String = "latitude"
    static let longitude:String = "longitude"
    static let created:String = "created"
    
    let latitude:Double
    let longitude:Double
    let created:TimeInterval
    
    init(
        latitude:Double,
        longitude:Double,
        created:TimeInterval)
    {
        self.latitude = latitude
        self.longitude = longitude
        self.created = created
    }
    
    //MARK: node protocol
    
    required init?(snapshot:Any)
    {
        guard
            
            let snapshotDict:[String:Any] = snapshot as? [String:Any],
            let latitude:Double = snapshotDict[FDbAlgoItem.latitude] as? Double,
            let longitude:Double = snapshotDict[FDbAlgoItem.longitude] as? Double,
            let created:TimeInterval = snapshotDict[FDbAlgoItem.created] as? TimeInterval
            
        else
        {
            return nil
        }
        
        self.latitude = latitude
        self.longitude = longitude
        self.created = created
    }
    
    func json() -> Any?
    {
        let json:[String:Any] = [
            FDbAlgoItem.latitude:latitude,
            FDbAlgoItem.longitude:longitude,
            FDbAlgoItem.created:created]
        
        return json
    }
}
