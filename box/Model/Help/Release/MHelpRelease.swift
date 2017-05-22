import Foundation

class MHelpRelease:MHelp
{
    init()
    {
        let itemIntro:MHelpReleaseIntro = MHelpReleaseIntro()
        let itemSpend:MHelpReleaseSpend = MHelpReleaseSpend()
        let itemLevel:MHelpReleaseLevel = MHelpReleaseLevel()
        let itemHarvest:MHelpReleaseHarvest = MHelpReleaseHarvest()
        
        let items:[MHelpProtocol] = [
            itemIntro,
            itemSpend,
            itemLevel,
            itemHarvest]
        
        super.init(items:items)
    }
}
