import Foundation

class MHelpDebug:MHelp
{
    init()
    {
        let itemIntro:MHelpDebugIntro = MHelpDebugIntro()
        
        let items:[MHelpProtocol] = [
            itemIntro]
        
        super.init(items:items)
    }
}
