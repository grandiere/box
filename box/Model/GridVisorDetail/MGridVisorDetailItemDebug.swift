import UIKit

class MGridVisorDetailItemDebug:MGridVisorDetailItem
{
    private let kCellHeight:CGFloat = 210
    
    init(model:MGridAlgoItemHostile)
    {
        let reusableIdentifier:String = VGridVisorDetailCellDebug.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
