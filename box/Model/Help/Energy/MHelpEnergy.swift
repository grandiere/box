import Foundation

class MHelpEnergy:MHelp
{
    init()
    {
        let itemIntro:MHelpReleaseIntro = MHelpReleaseIntro()
        let itemSpend:MHelpReleaseSpend = MHelpReleaseSpend()
        let itemLevel:MHelpReleaseLevel = MHelpReleaseLevel()
        
        let items:[MHelpProtocol] = [
            itemIntro,
            itemSpend,
            itemLevel]
        
        super.init(items:items)
    }
}
