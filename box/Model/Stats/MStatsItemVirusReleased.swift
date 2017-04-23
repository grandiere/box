import UIKit

class MStatsItemVirusReleased:MStatsItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetTextureBugDetail")
        let title:String = NSLocalizedString("MStatsItemVirusReleased_title", comment:"")
        let count:Int
        
        if let virus:Int16 = MSession.sharedInstance.settings?.stats?.virusReleased
        {
            count = Int(virus)
        }
        else
        {
            count = 0
        }
        
        super.init(
            image:image,
            title:title,
            count:count)
    }
}
