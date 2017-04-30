import UIKit

class MGridVisorDetailItemCreated:MGridVisorDetailItem
{
    let created:String
    private let kCellHeight:CGFloat = 55
    
    init(model:MGridAlgoItem)
    {
        let reusableIdentifier:String = VGridVisorDetailCellCreated.reusableIdentifier
        created = model.age()
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
