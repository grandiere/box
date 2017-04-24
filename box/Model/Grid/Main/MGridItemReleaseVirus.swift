import UIKit

class MGridItemReleaseVirus:MGridItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetGenericVisor")
        let title:String = NSLocalizedString("MGridItemReleaseVirus_title", comment:"")
        let subtitle:String = NSLocalizedString("MGridItemReleaseVirus_subtitle", comment:"")
        
        super.init(
            image:image,
            title:title,
            subtitle:subtitle)
    }
    
    override func selected(controller:CGrid)
    {
        controller.openVisor()
    }
}
