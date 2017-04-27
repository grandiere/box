import Foundation

class FDatabaseModelUserItem:FDatabaseModel
{
    enum Property:String
    {
        case created = "created"
        case shouldPost = "shouldPost"
    }
    
    let created:TimeInterval
    let shouldPost:Bool
    private let kShouldPost:Bool = true
    private let kShouldNotPost:Bool = false
    private let kNoTime:TimeInterval = 0
    
    override init?()
    {
        created = NSDate().timeIntervalSince1970
        shouldPost = kShouldPost
        
        super.init()
    }
    
    required init?(snapshot:Any)
    {
        let snapshotDict:[String:Any]? = snapshot as? [String:Any]
        
        if let created:TimeInterval = snapshotDict?[
            Property.created.rawValue] as? TimeInterval
        {
            self.created = created
        }
        else
        {
            self.created = kNoTime
        }
        
        if let shouldPost:Bool = snapshotDict?[
            Property.shouldPost.rawValue] as? Bool
        {
            self.shouldPost = shouldPost
        }
        else
        {
            self.shouldPost = kShouldNotPost
        }
        
        super.init()
    }
    
    override func modelJson() -> Any?
    {
        let json:[String:Any] = [
            Property.created.rawValue:created,
            Property.shouldPost.rawValue:shouldPost
        ]
        
        return json
    }
}
