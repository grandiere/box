import Foundation

class MHelpDebug:MHelp
{
    init()
    {
        let itemIntro:MHelpDebugIntro = MHelpDebugIntro()
        let itemStats:MHelpDebugStats = MHelpDebugStats()
        
        let items:[MHelpProtocol] = [
            itemIntro,
            itemStats]
        
        super.init(items:items)
    }
}
