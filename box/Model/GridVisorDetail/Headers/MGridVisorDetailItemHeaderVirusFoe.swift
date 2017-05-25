import UIKit

class MGridVisorDetailItemHeaderVirusFoe:MGridVisorDetailItemHeader
{
    init(model:MGridAlgoItemHostileVirusFoe)
    {
        let image:UIImage? = model.imageDetail()
        let title:String = NSLocalizedString("MGridVisorDetailItemHeaderVirusFoe_title", comment:"")
        
        super.init(image:image, title:title)
    }
}
