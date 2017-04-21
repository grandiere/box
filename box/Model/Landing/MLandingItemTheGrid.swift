import UIKit

class MLandingItemTheGrid:MLandingItem
{
    private let kCellHeight:CGFloat = 110
    
    init()
    {
        let reusableIdentifier:String = VLandingCellTheGrid.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
    
    override func selected(controller:CLanding)
    {
        controller.enterTheGrid()
    }
}
