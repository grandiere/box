import UIKit

class MGridVisorDetailItemTake:MGridVisorDetailItem
{
    private let kCellHeight:CGFloat = 320
    
    init(model:MGridAlgoItemAid)
    {
        let reusableIdentifier:String = VGridVisorDetailCellTake.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
