import Foundation

class MTutorialDebug:MTutorialProtocol
{
    var name:String
    {
        get
        {
            return NSLocalizedString("MTutorialDebug_name", comment:"")
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
