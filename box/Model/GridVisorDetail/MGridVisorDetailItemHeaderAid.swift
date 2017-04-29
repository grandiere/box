import UIKit

class MGridVisorDetailItemHeaderAid:MGridVisorDetailItemHeader
{
    init(model:MGridAlgoItemAid)
    {
        let image:UIImage? = model.imageDetail()
        let title:String = NSLocalizedString("MGridVisorDetailItemHeaderAid_title", comment:"")
        
        super.init(image:image, title:title)
    }
}
