import Foundation

class MProfileItemProcessor:MProfileItem
{
    init()
    {
        let title:String = NSLocalizedString("MProfileItemProcessor_title", comment:"")
        let value:Int
        
        if let skill:Int16 = MSession.sharedInstance.settings?.user?.processor
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
