import UIKit

class MStatsItemBugs:MStatsItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetTextureBugDetail")
        let title:String = NSLocalizedString("MStatsItemBugs_title", comment:"")
        let count:Int
        
        if let bugs:Int16 = MSession.sharedInstance.settings?.stats?.bugs
        {
            count = Int(bugs)
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
