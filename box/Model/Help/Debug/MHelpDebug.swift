import Foundation

class MHelpDebug:MHelp
{
    init()
    {
        let itemIntro:MHelpBasicIntro = MHelpBasicIntro()
        let itemMap:MHelpBasicMap = MHelpBasicMap()
        let itemVisor:MHelpBasicVisor = MHelpBasicVisor()
        let itemRelease:MHelpBasicRelease = MHelpBasicRelease()
        
        let items:[MHelpProtocol] = [
            itemIntro,
            itemMap,
            itemVisor,
            itemRelease]
        
        super.init(items:items)
    }
}
