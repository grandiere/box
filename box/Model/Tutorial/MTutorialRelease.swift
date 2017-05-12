import Foundation

class MTutorialRelease:MTutorialProtocol
{
    var name:String
    {
        get
        {
            return NSLocalizedString("MTutorialRelease_name", comment:"")
        }
    }
    
    var model:MHelp
    {
        get
        {
            return MHelpRelease()
        }
    }
}
