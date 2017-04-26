import UIKit

class MLandingBarSettings:MLandingBarProtocol
{
    var image:UIImage
    {
        get
        {
            return #imageLiteral(resourceName: "assetGenericSettings")
        }
    }
    
    //MARK: landingBar protocol
    
    func selected(controller:CLanding)
    {
    }
}
