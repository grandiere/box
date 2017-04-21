import Foundation

class MStats
{
    let items:[MStatsItem]
    
    init()
    {
        let itemBugs:MStatsItemBugs = MStatsItemBugs()
        
        items = [
            itemBugs]
    }
}
