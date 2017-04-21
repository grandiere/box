import Foundation

class MProfile
{
    let items:[MProfileItem]
    
    init()
    {
        let itemLevel:MProfileItemLevel = MProfileItemLevel()
        let itemSkill:MProfileItemSkill = MProfileItemSkill()
        let itemMemory:MProfileItemMemory = MProfileItemMemory()
        let itemNetwork:MProfileItemNetwork = MProfileItemNetwork()
        let itemProcessor:MProfileItemProcessor = MProfileItemProcessor()
        
        items = [
            itemLevel,
            itemSkill,
            itemMemory,
            itemNetwork,
            itemProcessor]
    }
}
