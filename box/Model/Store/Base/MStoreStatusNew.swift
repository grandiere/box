import UIKit

class MStoreStatusNew:MStoreStatusProtocol
{
    private let kCellHeight:CGFloat = 40
    
    var reusableIdentifier:String
    {
        get
        {
            return VStoreCellNew.reusableIdentifier
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
