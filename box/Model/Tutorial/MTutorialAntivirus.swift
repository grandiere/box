import Foundation

class MTutorialAntivirus:MTutorialProtocol
{
    var name:String
    {
        get
        {
            return NSLocalizedString("MTutorialAntivirus_name", comment:"")
        }
    }
    
    var model:MHelp
    {
        get
        {
            return MHelpAntivirus()
        }
    }
}
