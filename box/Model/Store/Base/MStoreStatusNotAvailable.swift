import UIKit

class MStoreStatusNotAvailable:MStoreStatusProtocol
{
    private let kCellHeight:CGFloat = 50
    
    var reusableIdentifier:String
    {
        get
        {
            return VStoreCellNotAvailable.reusableIdentifier
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
