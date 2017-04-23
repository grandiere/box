import Foundation

class MStats
{
    let items:[MStatsItem]
    
    init()
    {
        let itemBugs:MStatsItemBugs = MStatsItemBugs()
        let itemVirus:MStatsItemVirus = MStatsItemVirus()
        let itemVirusReleased:MStatsItemVirusReleased = MStatsItemVirusReleased()
        
        items = [
            itemBugs,
            itemVirus,
            itemVirusReleased]
    }
}
