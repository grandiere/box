import UIKit

class MGridItemHarvest:MGridItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetGenericHarvest")
        let title:String = NSLocalizedString("MGridItemHarvest_title", comment:"")
        let subtitle:String = NSLocalizedString("MGridItemHarvest_subtitle", comment:"")
        
        super.init(
            image:image,
            title:title,
            subtitle:subtitle)
    }
    
    override func selected(controller:CGrid)
    {
        controller.openHarvest()
    }
}
