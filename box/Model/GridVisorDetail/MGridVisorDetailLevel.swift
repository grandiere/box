import UIKit

class MGridVisorDetailLevel:MGridVisorDetailProtocol
{
    let level:Int
    private let kCellHeight:CGFloat = 100
    
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
            return VGridVisorDetailCellLevel.reusableIdentifier
        }
    }
    
    init(model:MGridAlgoHostileItem)
    {
        level = model.level
    }
}
