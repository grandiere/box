import UIKit

class MGridVisorDetailAge:MGridVisorDetailProtocol
{
    let distance:Double?
    private let kCellHeight:CGFloat = 130
    
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
        distance = model.age()
    }
}
