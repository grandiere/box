import UIKit

class MStatsItemVirus:MStatsItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetTextureVirusFoeDetail")
        let title:String = NSLocalizedString("MStatsItemVirus_title", comment:"")
        let count:Int
        
        if let virus:Int16 = MSession.sharedInstance.settings?.stats?.virus
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
