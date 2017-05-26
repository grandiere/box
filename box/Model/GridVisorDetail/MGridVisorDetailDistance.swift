import UIKit

class MGridVisorDetailDistance:MGridVisorDetailProtocol
{
    let distance:Double?
    private let kCellHeight:CGFloat = 110
    
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
            return VGridVisorDetailCellDistance.reusableIdentifier
        }
    }
    
    init(model:MGridAlgoItem)
    {
        distance = model.distance
    }
}
