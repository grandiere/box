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
        let itemLevel:MGridVisorDetailItemLevel = MGridVisorDetailItemLevel(
            model:model)
        let itemCreated:MGridVisorDetailItemCreated = MGridVisorDetailItemCreated(
            model:model)
        let itemMatch:MGridVisorDetailItemMatch = MGridVisorDetailItemMatch(
            model:model)
        
        let items:[MGridVisorDetailItem] = [
            itemHeader,
            itemDistance,
            itemLevel,
            itemCreated,
            itemMatch]
        
        let detail:MGridVisorDetail = MGridVisorDetail(items:items)
        
        return detail
    }
    
    class func detailVirusFriendly(model:MGridAlgoItemHostileVirusFriendly) -> MGridVisorDetail
    {
        let itemHeader:MGridVisorDetailItemHeaderVirusFriendly = MGridVisorDetailItemHeaderVirusFriendly(
            model:model)
        let itemDistance:MGridVisorDetailItemDistance = MGridVisorDetailItemDistance(
            model:model)
        let itemLevel:MGridVisorDetailItemLevel = MGridVisorDetailItemLevel(
            model:model)
        let itemCreated:MGridVisorDetailItemCreated = MGridVisorDetailItemCreated(
            model:model)
        
        let items:[MGridVisorDetailItem] = [
            itemHeader,
            itemDistance,
            itemLevel,
            itemCreated]
        
        let detail:MGridVisorDetail = MGridVisorDetail(items:items)
        
        return detail
    }
    
    class func detailAid(model:MGridAlgoItemAid) -> MGridVisorDetail
    {
        let itemHeader:MGridVisorDetailItemHeaderAid = MGridVisorDetailItemHeaderAid(
            model:model)
        let itemDistance:MGridVisorDetailItemDistance = MGridVisorDetailItemDistance(
            model:model)
        let itemCreated:MGridVisorDetailItemCreated = MGridVisorDetailItemCreated(
            model:model)
        let itemTake:MGridVisorDetailItemTake = MGridVisorDetailItemTake(
            model:model)
        
        let items:[MGridVisorDetailItem] = [
            itemHeader,
            itemDistance,
            itemCreated,
            itemTake]
        
        let detail:MGridVisorDetail = MGridVisorDetail(items:items)
        
        return detail
    }
    
    init(items:[MGridVisorDetailItem] = [])
    {
        self.items = items
    }
}
