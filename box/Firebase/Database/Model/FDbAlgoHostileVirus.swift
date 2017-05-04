import Foundation

class FDbAlgoHostileVirus:FDbProtocol
{
    let items:[String:FDbAlgoHostileBugItem]
    
    required init?(snapshot:Any)
    {
        var items:[String:FDbAlgoHostileBugItem] = [:]
        
        if let snapshotDict:[String:Any] = snapshot as? [String:Any]
        {
            let snapshotKeys:[String] = Array(snapshotDict.keys)
            
            for bugId:String in snapshotKeys
            {
                guard
                    
                    let snapshotBug:Any = snapshotDict[bugId],
                    let bugItem:FDbAlgoHostileBugItem = FDbAlgoHostileBugItem(
                        snapshot:snapshotBug)
                    
                    else
                {
                    continue
                }
                
                items[bugId] = bugItem
            }
        }
        
        self.items = items
    }
    
    func json() -> Any?
    {
        return nil
    }
}
