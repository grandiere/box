import Foundation

class MProfile
{
    let items:[MProfileItem]
    
    init()
    {
        let itemLevel:MProfileItemLevel = MProfileItemLevel()
        let itemSkill:MProfileItemSkill = MProfileItemSkill()
        
        items = [
            itemLevel,
            itemSkill]
    }
}
