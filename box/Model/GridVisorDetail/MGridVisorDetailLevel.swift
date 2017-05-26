import UIKit

class MGridVisorDetailLevel:MGridVisorDetailProtocol
{
    let level:Int
    private let kCellHeight:CGFloat = 120
    
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
            return VGridVisorDetailCellAge.reusableIdentifier
        }
    }
    
    init(model:MGridAlgoHostileItem)
    {
        level = model.level
    }
}
