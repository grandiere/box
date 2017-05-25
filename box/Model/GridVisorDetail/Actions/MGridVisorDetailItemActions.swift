import UIKit

class MGridVisorDetailItemActions:MGridVisorDetailItem
{
    let items:
    private let kCellHeight:CGFloat = 100
    
    init(model:MGridAlgoItemAid)
    {
        let reusableIdentifier:String = VGridVisorDetailCellActions.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
