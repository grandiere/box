import Foundation

class MStats
{
    let items:[MStatsItem]
    
    init()
    {
        let itemBugs:MStatsItemBugs = MStatsItemBugs()
        let itemVirus:MStatsItemVirus = MStatsItemVirus()
        
        items = [
            itemBugs,
            itemVirus]
    }
}
