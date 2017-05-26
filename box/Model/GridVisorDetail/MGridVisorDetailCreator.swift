import UIKit

class MGridVisorDetailCreator:MGridVisorDetailProtocol
{
    let userId:String
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
            return VGridVisorDetailCellCreator.reusableIdentifier
        }
    }
    
    init(model:MGridAlgoHostileVirusFoeItem)
    {
        userId = model.userId
    }
}
