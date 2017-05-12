import Foundation

class MHelpAntivirus:MHelp
{
    init()
    {
        let itemIntro:MHelpAntivirusIntro = MHelpAntivirusIntro()
        
        let items:[MHelpProtocol] = [
            itemIntro]
        
        super.init(items:items)
    }
}
