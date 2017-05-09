import UIKit

class MLandingBarStore:MLandingBarProtocol
{
    var image:UIImage
    {
        get
        {
            return #imageLiteral(resourceName: "assetGenericStore")
        }
    }
    
    //MARK: landingBar protocol
    
    func selected(controller:CLanding)
    {
        controller.openStore()
    }
}
