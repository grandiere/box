import UIKit

class MGridVisorDetailKills:MGridVisorDetailProtocol
{
    let kills:Int
    private let kCellHeight:CGFloat = 60
    
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
            return VGridVisorDetailCellKills.reusableIdentifier
        }
    }
    
    init(model:MGridAlgoHostileItem)
    {
        kills = model.defeated
    }
}
