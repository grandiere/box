import Foundation

class MHelpBasic:MHelp
{
    init()
    {
        let itemIntro:MHelpBasicIntro = MHelpBasicIntro()
        let itemMap:MHelpBasicMap = MHelpBasicMap()
        let itemVisor:MHelpBasicVisor = MHelpBasicVisor()
        
        let items:[MHelpProtocol] = [
            itemIntro,
            itemMap,
            itemVisor]
        
        super.init(items:items)
    }
}
