import Foundation

class MBoardsSortKills:MBoardsSortProtocol
{
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
                let comparison:ComparisonResult = itemA.handler.compare(itemB.handler)
                
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
