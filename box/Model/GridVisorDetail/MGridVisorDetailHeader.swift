import UIKit

class MGridVisorDetailHeader:MGridVisorDetailProtocol
{
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
        
    }
}
