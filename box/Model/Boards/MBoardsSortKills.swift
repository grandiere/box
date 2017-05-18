import Foundation

class MBoardsSortKills:MBoardsSortProtocol
{
    var reusableIdentifier:String
    {
        get
        {
            return VBoardsCellKills.reusableIdentifier
        }
    }
    
    func sort(items:[MBoardsItem]) -> [MBoardsItem]
    {
        let sorted:[MBoardsItem] = items.sorted
        { (itemA:MBoardsItem, itemB:MBoardsItem) -> Bool in
            
            if itemA.kills > itemB.kills
            {
                return true
            }
            else if itemA.kills == itemB.kills
            {
                let comparison:ComparisonResult = itemA.handler.compare(
                    itemB.handler,
                    options:String.CompareOptions.caseInsensitive)
                
                switch comparison
                {
                case ComparisonResult.orderedAscending:
                    
                    return true
                    
                case ComparisonResult.orderedDescending,
                     ComparisonResult.orderedSame:
                    
                    return false
                }
            }
            
            return false
        }
        
        return sorted
    }
}
