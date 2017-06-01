import Foundation

class MGrid
{
    let items:[MGridItem]
    
    init()
    {
        let itemMap:MGridItemMap = MGridItemMap()
        let itemVisor:MGridItemVisor = MGridItemVisor()
        let itemReleaseVirus:MGridItemReleaseVirus = MGridItemReleaseVirus()
        let itemHarvest:MGridItemHarvest = MGridItemHarvest()
        
        items = [
            itemVisor,
            itemMap,
            itemReleaseVirus,
            itemHarvest]
    }
}
