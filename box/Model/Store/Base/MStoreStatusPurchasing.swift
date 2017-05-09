import UIKit

class MStoreStatusPurchasing:MStoreStatusProtocol
{
    private let kCellHeight:CGFloat = 30
    
    var reusableIdentifier:String
    {
        get
        {
            return VStoreCellPurchasing.reusableIdentifier
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
