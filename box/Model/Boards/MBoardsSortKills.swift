import Foundation

class MBoardsSortKills:MBoardsSortProtocol
{
    func sort(items:[MBoardsItem]) -> [MBoardsItem]
    {
        let sorted:[MBoardsItem] = items.sorted
        { (itemA:MBoardsItem, itemB:MBoardsItem) -> Bool in
            
            if itemA.score > itemB.score
            {
                return true
            }
            
            return false
        }
        
        return sorted
    }
}
