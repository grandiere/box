import UIKit

class MGridVisorDetailItemHeaderVirusFriendly:MGridVisorDetailItemHeader
{
    init(model:MGridAlgoHostileVirusFriendlyItem)
    {
        let image:UIImage? = model.imageDetail()
        let title:String = NSLocalizedString("MGridVisorDetailItemHeaderVirusFriendly_title", comment:"")
        
        super.init(image:image, title:title)
    }
}
