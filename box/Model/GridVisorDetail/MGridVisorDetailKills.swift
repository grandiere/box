import UIKit

class MGridVisorDetailKills:MGridVisorDetailProtocol
{
    let distance:Double?
    private let kCellHeight:CGFloat = 80
    
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
    
    init(model:MGridAlgoItem)
    {
        distance = model.distance
    }
}
