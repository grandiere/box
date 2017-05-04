import Foundation

class FDbAlgoHostileVirus:FDbProtocol
{
    let items:[String:FDbAlgoHostileVirusItem]
    
    required init?(snapshot:Any)
    {
        var items:[String:FDbAlgoHostileVirusItem] = [:]
        
        if let snapshotDict:[String:Any] = snapshot as? [String:Any]
        {
            let snapshotKeys:[String] = Array(snapshotDict.keys)
            
            for virusId:String in snapshotKeys
            {
                guard
                    
                    let snapshotVirus:Any = snapshotDict[virusId],
                    let virusItem:FDbAlgoHostileVirusItem = FDbAlgoHostileVirusItem(
                        snapshot:snapshotVirus)
                    
                else
                {
                    continue
                }
                
                items[virusId] = virusItem
            }
        }
        
        self.items = items
    }
    
    func json() -> Any?
    {
        return nil
    }
}
