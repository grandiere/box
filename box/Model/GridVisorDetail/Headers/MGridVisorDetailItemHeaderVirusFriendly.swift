import UIKit

class MGridVisorDetailItemHeaderVirusFriendly:MGridVisorDetailItemHeader
{
    init(model:MGridAlgoHostileVirusFriendlyItem)
    {
        let image:UIImage? = model.icon
        let title:String = NSLocalizedString("MGridVisorDetailItemHeaderVirusFriendly_title", comment:"")
        
        super.init(image:image, title:title)
    }
}
