import Foundation

class MHelpAntivirus:MHelp
{
    init()
    {
        let itemIntro:MHelpDebugIntro = MHelpDebugIntro()
        let itemStats:MHelpDebugStats = MHelpDebugStats()
        let itemDistance:MHelpDebugDistance = MHelpDebugDistance()
        
        let items:[MHelpProtocol] = [
            itemIntro,
            itemStats,
            itemDistance]
        
        super.init(items:items)
    }
}
