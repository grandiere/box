import UIKit

class MGridVisorDetailItemActionsBack:MGridVisorDetailItemActionsProtocol
{
    var icon:UIImage
    {
        get
        {
            return #imageLiteral(resourceName: "assetGenericLogo")
        }
    }
    
    func selected(controller:CGridVisorDetail)
    {
        controller.back()
    }
}
