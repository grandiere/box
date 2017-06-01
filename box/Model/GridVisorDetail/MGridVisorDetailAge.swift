import UIKit

class MGridVisorDetailAge:MGridVisorDetailProtocol
{
    let age:String
    private let kCellHeight:CGFloat = 50
    
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
    
    init(model:MGridAlgoItem)
    {
        age = model.age()
    }
}
