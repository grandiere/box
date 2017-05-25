import UIKit

class MGridVisorDetailItemActionsTake:MGridVisorDetailItemActionsProtocol
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
        controller.enterTake()
    }
}
