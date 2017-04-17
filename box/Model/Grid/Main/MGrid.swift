import Foundation

class MGrid
{
    let items:[MGridItem]
    
    init()
    {
        let itemMap:MGridItemMap = MGridItemMap()
        let itemVisor:MGridItemVisor = MGridItemVisor()
        
        items = [
            itemMap,
            itemVisor]
    }
}
