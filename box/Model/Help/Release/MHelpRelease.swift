import Foundation

class MHelpRelease:MHelp
{
    init()
    {
        let itemIntro:MHelpReleaseIntro = MHelpReleaseIntro()
        let itemSpend:MHelpReleaseSpend = MHelpReleaseSpend()
        
        let items:[MHelpProtocol] = [
            itemIntro,
            itemSpend]
        
        super.init(items:items)
    }
}
