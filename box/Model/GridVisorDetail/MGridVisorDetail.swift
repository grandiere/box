import Foundation

class MGridVisorDetail
{
    let items:[MGridVisorDetailItem]
    
    class func detailBug(model:MGridAlgoItemHostileBug) -> MGridVisorDetail
    {
        let itemHeader:MGridVisorDetailItemHeaderBug = MGridVisorDetailItemHeaderBug(
            model:model)
        let itemDistance:MGridVisorDetailItemDistance = MGridVisorDetailItemDistance(
            model:model)
        
        let items:[MGridVisorDetailItem] = [
            itemHeader,
            itemDistance]
        
        let detail:MGridVisorDetail = MGridVisorDetail(items:items)
        
        return detail
    }
    
    init(items:[MGridVisorDetailItem] = [])
    {
        self.items = items
    }
}
