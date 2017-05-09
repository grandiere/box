import UIKit

class MStoreStatusDeferred:MStoreStatusProtocol
{
    private let kCellHeight:CGFloat = 50
    
    var reusableIdentifier:String
    {
        get
        {
            return ""
        }
    }
    
    var cellHeight:CGFloat
    {
        get
        {
            return kCellHeight
        }
    }
}
