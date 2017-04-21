import UIKit

class MLandingItemTheProfile:MLandingItem
{
    init()
    {
        let title:String = NSLocalizedString("MLandingItemTheProfile_title", comment:"")
        
        super.init(
            icon:#imageLiteral(resourceName: "assetGenericTheGrid"),
            title:title)
    }
    
    override func selected(controller:CLanding)
    {
        controller.enterTheGrid()
    }
}
