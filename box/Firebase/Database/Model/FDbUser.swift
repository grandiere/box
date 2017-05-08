import Foundation

class FDbUser:FDbProtocol
{
    let items:[String:FDbUserItem]
    
    required init?(snapshot:Any)
    {
        var items:[String:FDbUserItem] = [:]
        
        if let snapshotDict:[String:Any] = snapshot as? [String:Any]
        {
            let snapshotKeys:[String] = Array(snapshotDict.keys)
            
            for userId:String in snapshotKeys
            {
                guard
                    
                    let snapshotUser:Any = snapshotDict[userId],
                    let userItem:FDbUserItem = FDbUserItem(snapshot:snapshotUser)
                    
                else
                {
                    continue
                }
                
                items[userId] = userItem
            }
        }
        
        self.items = items
    }
    
    func json() -> Any?
    {
        return nil
    }
}
