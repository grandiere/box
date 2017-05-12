import Foundation

class MHelpRelease:MHelp
{
    init()
    {
        let itemIntro:MHelpAntivirusIntro = MHelpAntivirusIntro()
        let itemStats:MHelpAntivirusStats = MHelpAntivirusStats()
        let itemDistance:MHelpAntivirusDistance = MHelpAntivirusDistance()
        
        let items:[MHelpProtocol] = [
            itemIntro,
            itemStats,
            itemDistance]
        
        super.init(items:items)
    }
}
