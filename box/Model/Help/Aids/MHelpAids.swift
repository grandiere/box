import Foundation

class MHelpAids:MHelp
{
    init()
    {
        let itemIntro:MHelpAidsIntro = MHelpAidsIntro()
        let itemSkills:MHelpAidsSkills = MHelpAidsSkills()
        let itemEnergy:MHelpAidsEnergy = MHelpAidsEnergy()
        
        let items:[MHelpProtocol] = [
            itemIntro,
            itemSkills,
            itemEnergy]
        
        super.init(items:items)
    }
}
