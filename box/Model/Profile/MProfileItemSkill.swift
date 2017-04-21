import Foundation

class MProfileItemSkill:MProfileItem
{
    init()
    {
        let title:String = NSLocalizedString("MProfileItemSkill_title", comment:"")
        let value:Int
        
        if let skill:Int16 = MSession.sharedInstance.settings?.user?.skill
        {
            value = Int(skill)
        }
        else
        {
            value = 0
        }
        
        super.init(
            title:title,
            value:value)
    }
}
