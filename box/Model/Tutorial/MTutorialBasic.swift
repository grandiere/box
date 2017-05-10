import Foundation

class MTutorialBasic:MTutorialProtocol
{
    var name:String
    {
        get
        {
            return NSLocalizedString("MTutorialBasic_name", comment:"")
        }
    }
    
    var model:MHelp
    {
        get
        {
            return MHelpBasic()
        }
    }
}
