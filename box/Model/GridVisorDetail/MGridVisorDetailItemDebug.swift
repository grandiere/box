import UIKit

class MGridVisorDetailItemDebug:MGridVisorDetailItem
{
    private let kCellHeight:CGFloat = 150
    
    init(model:MGridAlgoItemHostile)
    {
        let reusableIdentifier:String = VGridVisorDetailCellDebug.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
