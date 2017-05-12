import Foundation

class MHelpSkills:MHelp
{
    init()
    {
        let itemIntro:MHelpSkillsIntro = MHelpSkillsIntro()
        let itemAids:MHelpSkillsAids = MHelpSkillsAids()
        let itemPurchase:MHelpSkillsPurchase = MHelpSkillsPurchase()
        
        let items:[MHelpProtocol] = [
            itemIntro,
            itemAids,
            itemPurchase]
        
        super.init(items:items)
    }
}
