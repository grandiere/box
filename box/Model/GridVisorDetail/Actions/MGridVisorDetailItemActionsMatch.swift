import UIKit

class MGridVisorDetailItemActionsMatch:MGridVisorDetailItemActionsProtocol
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
        controller.enterMach()
    }
}
