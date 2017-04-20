import UIKit

class MGridVisorDetailItemLevel:MGridVisorDetailItem
{
    let level:Int
    private let kCellHeight:CGFloat = 80
    
    init(model:MGridAlgoItemHostile)
    {
        let reusableIdentifier:String = VGridVisorDetailCellLevel.reusableIdentifier
        level = model.level
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
