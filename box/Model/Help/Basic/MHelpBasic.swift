import Foundation

class MHelpBasic:MHelp
{
    init()
    {
        let itemIntro:MHelpBasicIntro = MHelpBasicIntro()
        
        let items:[MHelpProtocol] = [
            itemIntro]
        
        super.init(items:items)
    }
}
