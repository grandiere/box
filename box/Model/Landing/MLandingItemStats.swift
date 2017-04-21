import UIKit

class MLandingItemTheStats:MLandingItem
{
    init()
    {
        let title:String = NSLocalizedString("MLandingItemTheStats_title", comment:"")
        
        super.init(
            icon:#imageLiteral(resourceName: "assetGenericTheGrid"),
            title:title)
    }
    
    override func selected(controller:CLanding)
    {
        controller.enterTheGrid()
    }
}
