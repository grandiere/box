import UIKit

class MGridVisorDetailItemActions:MGridVisorDetailItem
{
    private let kCellHeight:CGFloat = 100
    
    init(model:MGridAlgoAidItem)
    {
        let reusableIdentifier:String = VGridVisorDetailCellActions.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
