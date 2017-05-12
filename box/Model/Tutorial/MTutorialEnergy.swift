import Foundation

class MTutorialEnergy:MTutorialProtocol
{
    var name:String
    {
        get
        {
            return NSLocalizedString("MTutorialEnergy_name", comment:"")
        }
    }
    
    var model:MHelp
    {
        get
        {
            return MHelpEnergy()
        }
    }
}
