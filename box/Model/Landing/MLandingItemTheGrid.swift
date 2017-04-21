import UIKit

class MLandingItemTheGrid:MLandingItem
{
    init()
    {
        let title:String = NSLocalizedString("MLandingItemTheGrid_title", comment:"")
        
        super.init(
            icon:#imageLiteral(resourceName: "assetGenericTheGrid"),
            title:title)
    }
    
    override func selected(controller:CLanding)
    {
        controller.enterTheGrid()
    }
}
