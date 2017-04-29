import UIKit

class MGridVisorDetailItemMatch:MGridVisorDetailItem
{
    let credits:Int
    let title:String?
    private let kCellHeight:CGFloat = 280
    
    init(model:MGridAlgoItemHostile)
    {
        let reusableIdentifier:String = VGridVisorDetailCellMatch.reusableIdentifier
        credits = model.credits
        title = model.titleMatch()
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
