import UIKit

class MGridVisorDetailItemHeader:MGridVisorDetailItem
{
    let image:UIImage?
    let title:String
    private let kCellHeight:CGFloat = 100
    
    init(image:UIImage?, title:String)
    {
        self.image = image
        self.title = title
        let reusableIdentifier:String = VGridVisorDetailCellHeader.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
