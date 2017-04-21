import Foundation

class MProfileItemMemory:MProfileItem
{
    init()
    {
        let title:String = NSLocalizedString("MProfileItemMemory_title", comment:"")
        let value:Int
        
        if let memory:Int16 = MSession.sharedInstance.settings?.user?.memory
        {
            value = Int(memory)
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
