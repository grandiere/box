import UIKit

class MGridVisorDetailItemMatch:MGridVisorDetailItem
{
    let credits:Int
    private let kCellHeight:CGFloat = 280
    
    init(model:MGridAlgoItemHostile)
    {
        let reusableIdentifier:String = VGridVisorDetailCellMatch.reusableIdentifier
        credits = model.credits
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
