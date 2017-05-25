import UIKit

class MGridVisorDetailItemHeaderBug:MGridVisorDetailItemHeader
{
    init(model:MGridAlgoHostileBugItem)
    {
        let image:UIImage? = model.imageDetail()
        let title:String = NSLocalizedString("MGridVisorDetailItemHeaderBug_title", comment:"")
        
        super.init(image:image, title:title)
    }
}
