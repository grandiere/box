import UIKit

class MGridItemVisor:MGridItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetGenericVisor")
        let title:String = NSLocalizedString("MGridItemVisor_title", comment:"")
        let subtitle:String = NSLocalizedString("MGridItemVisor_subtitle", comment:"")
        
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
