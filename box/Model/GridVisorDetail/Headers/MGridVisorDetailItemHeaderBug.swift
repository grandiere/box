import UIKit

class MGridVisorDetailItemHeaderBug:MGridVisorDetailItemHeader
{
    init(model:MGridAlgoHostileBugItem)
    {
        let image:UIImage? = model.icon
        let title:String = NSLocalizedString("MGridVisorDetailItemHeaderBug_title", comment:"")
        
        super.init(image:image, title:title)
    }
}
