import Foundation

class MProfile
{
    let items:[MProfileItem]
    
    init()
    {
        let itemSkill:MProfileItemSkill = MProfileItemSkill()
        
        items = [
            itemSkill]
    }
}
