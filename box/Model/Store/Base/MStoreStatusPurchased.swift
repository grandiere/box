import UIKit

class MStoreStatusPurchased:MStoreStatusProtocol
{
    private let kCellHeight:CGFloat = 40
    
    var reusableIdentifier:String
    {
        get
        {
            return VStoreCellPurchased.reusableIdentifier
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
