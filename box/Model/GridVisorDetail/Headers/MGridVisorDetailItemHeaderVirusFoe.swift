import UIKit

class MGridVisorDetailItemHeaderVirusFoe:MGridVisorDetailItemHeader
{
    init(model:MGridAlgoHostileVirusFoeItem)
    {
        let image:UIImage? = model.icon
        let title:String = NSLocalizedString("MGridVisorDetailItemHeaderVirusFoe_title", comment:"")
        
        super.init(image:image, title:title)
    }
}
