import Foundation

class MProfileItemLevel:MProfileItem
{
    init()
    {
        let title:String = NSLocalizedString("MProfileItemLevel_title", comment:"")
        let value:Int = MSession.sharedInstance.level
        
        super.init(
            title:title,
            value:value)
    }
}
