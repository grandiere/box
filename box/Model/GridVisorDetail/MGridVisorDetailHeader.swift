import UIKit

class MGridVisorDetailHeader:MGridVisorDetailProtocol
{
    let icon:UIImage?
    private let kCellHeight:CGFloat = 200
    
    var cellHeight:CGFloat
    {
        get
        {
            return kCellHeight
        }
    }
    
    var reusableIdentifier:String
    {
        get
        {
            return VGridVisorDetailCellHeader.reusableIdentifier
        }
    }
    
    init(model:MGridAlgoItem)
    {
        icon = model.icon
    }
}
