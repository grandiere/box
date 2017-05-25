import UIKit

class MGridVisorDetailDistance:MGridVisorDetailProtocol
{
    let icon:UIImage?
    let title:String?
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
        title = model.algoTitle
    }
}
