import Foundation

class MProfileItemProcessor:MProfileItem
{
    init()
    {
        let title:String = NSLocalizedString("MProfileItemProcessor_title", comment:"")
        let value:Int
        
        if let processor:Int16 = MSession.sharedInstance.settings?.user?.processor
        {
            value = Int(processor)
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
