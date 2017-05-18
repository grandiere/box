import Foundation

class MBoardsSortScore:MBoardsSortProtocol
{
    var reusableIdentifier:String
    {
        get
        {
            return VBoardsCellScore.reusableIdentifier
        }
    }
    
    func sort(items:[MBoardsItem]) -> [MBoardsItem]
    {
        let sorted:[MBoardsItem] = items.sorted
        { (itemA:MBoardsItem, itemB:MBoardsItem) -> Bool in
                
            if itemA.score > itemB.score
            {
                return true
            }
            else if itemA.score == itemB.score
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
