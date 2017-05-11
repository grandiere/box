import UIKit

class MLandingBarHelp:MLandingBarProtocol
{
    var image:UIImage
    {
        get
        {
            return #imageLiteral(resourceName: "assetGenericHelp")
        }
    }
    
    //MARK: landingBar protocol
    
    func selected(controller:CLanding)
    {
        controller.openTutorial()
    }
}
