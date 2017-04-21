import UIKit

class MLandingItemTheProfile:MLandingItem
{
    init()
    {
        let title:String = NSLocalizedString("MLandingItemTheProfile_title", comment:"")
        
        super.init(
            icon:#imageLiteral(resourceName: "assetGenericProfile"),
            title:title)
    }
    
    override func selected(controller:CLanding)
    {
        controller.enterTheGrid()
    }
}
