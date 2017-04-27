import Foundation

class FDatabaseModelGalleryItem:FDatabaseModel
{
    enum Property:String
    {
        case available = "available"
        case created = "created"
        case updated = "updated"
        case userId = "userId"
        case likes = "likes"
    }
    
    let available:Bool
    let created:TimeInterval
    let updated:TimeInterval
    let userId:String
    let likes:Int
    private let kInitialLikes:Int = 0
    private let kInitialAvailability:Bool = true
    private let kNoTime:TimeInterval = 0
    private let kNotAvailable:Bool = false
    
    init?(userId:String)
    {
        available = kInitialAvailability
        created = NSDate().timeIntervalSince1970
        updated = created
        likes = kInitialLikes
        self.userId = userId
        
        super.init()
    }
    
    required init?(snapshot:Any)
    {
        let snapshotDict:[String:Any]? = snapshot as? [String:Any]
        
        if let available:Bool = snapshotDict?[
            Property.available.rawValue] as? Bool
        {
            self.available = available
        }
        else
        {
            self.available = kNotAvailable
        }
        
        if let created:TimeInterval = snapshotDict?[
            Property.created.rawValue] as? TimeInterval
        {
            self.created = created
        }
        else
        {
            self.created = kNoTime
        }
        
        if let updated:TimeInterval = snapshotDict?[
            Property.updated.rawValue] as? TimeInterval
        {
            self.updated = updated
        }
        else
        {
            self.updated = kNoTime
        }
        
        if let likes:Int = snapshotDict?[
            Property.likes.rawValue] as? Int
        {
            
            self.likes = likes
        }
        else
        {
            self.likes = kInitialLikes
        }
        
        guard
            
            let userId:String = snapshotDict?[
                Property.userId.rawValue] as? String
        
        else
        {
            return nil
        }
        
        self.userId = userId
        
        super.init()
    }
    
    override func modelJson() -> Any?
    {
        let json:[String:Any] = [
            Property.available.rawValue:available,
            Property.created.rawValue:created,
            Property.updated.rawValue:updated,
            Property.likes.rawValue:likes,
            Property.userId.rawValue:userId
        ]
        
        return json
    }
}
