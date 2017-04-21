import Foundation

class MProfileItemLevel:MProfileItem
{
    init()
    {
        let title:String = NSLocalizedString("MProfileItemLevel_title", comment:"")
        let value:Int
        
        if let skill:Int16 = MSession.sharedInstance.settings?.user?.level
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
