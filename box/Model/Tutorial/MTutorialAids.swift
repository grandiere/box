import Foundation

class MTutorialAids:MTutorialProtocol
{
    var name:String
    {
        get
        {
            return NSLocalizedString("MTutorialAids_name", comment:"")
        }
    }
    
    var model:MHelp
    {
        get
        {
            return MHelpAids()
        }
    }
}
