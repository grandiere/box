import Foundation

class MTutorialSkills:MTutorialProtocol
{
    var name:String
    {
        get
        {
            return NSLocalizedString("MTutorialSkills_name", comment:"")
        }
    }
    
    var model:MHelp
    {
        get
        {
            return MHelpSkills()
        }
    }
}
