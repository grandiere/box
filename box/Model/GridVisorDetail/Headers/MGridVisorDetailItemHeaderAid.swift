import UIKit

class MGridVisorDetailItemHeaderAid:MGridVisorDetailItemHeader
{
    init(model:MGridAlgoAidItem)
    {
        let image:UIImage? = model.icon
        let title:String = NSLocalizedString("MGridVisorDetailItemHeaderAid_title", comment:"")
        
        super.init(image:image, title:title)
    }
}
