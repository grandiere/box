import UIKit

class MGridItemMap:MGridItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetGenericMap")
        let title:String = NSLocalizedString("MGridItemMap_title", comment:"")
        let subtitle:String = NSLocalizedString("MGridItemMap_subtitle", comment:"")
        
        super.init(
            image:image,
            title:title,
            subtitle:subtitle)
    }
}
