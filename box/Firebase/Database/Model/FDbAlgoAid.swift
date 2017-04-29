import Foundation

class FDbAlgoAid:FDbProtocol
{
    let items:[String:FDbAlgoAidItem]
    
    required init?(snapshot:Any)
    {
        var items:[String:FDbAlgoAidItem] = [:]
        
        if let snapshotDict:[String:Any] = snapshot as? [String:Any]
        {
            let snapshotKeys:[String] = Array(snapshotDict.keys)
            
            for aidId:String in snapshotKeys
            {
                guard
                    
                    let snapshotAid:Any = snapshotDict[aidId],
                    let aidItem:FDbAlgoAidItem = FDbAlgoAidItem(
                        snapshot:snapshotAid)
                    
                else
                {
                    continue
                }
                
                items[aidId] = aidItem
            }
        }
        
        self.items = items
    }
    
    func json() -> Any?
    {
        return nil
    }
}
