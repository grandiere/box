import Foundation

class MProfileItemNetwork:MProfileItem
{
    init()
    {
        let title:String = NSLocalizedString("MProfileItemNetwork_title", comment:"")
        let value:Int
        
        if let network:Int16 = MSession.sharedInstance.settings?.user?.network
        {
            value = Int(network)
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
