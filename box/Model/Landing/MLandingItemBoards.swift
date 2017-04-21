import UIKit

class MLandingItemTheBoards:MLandingItem
{
    init()
    {
        let title:String = NSLocalizedString("MLandingItemTheBoards_title", comment:"")
        
        super.init(
            icon:#imageLiteral(resourceName: "assetGenericTheGrid"),
            title:title)
    }
    
    override func selected(controller:CLanding)
    {
        controller.enterTheGrid()
    }
}
