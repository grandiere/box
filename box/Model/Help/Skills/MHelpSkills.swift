import Foundation

class MHelpSkills:MHelp
{
    init()
    {
        let itemIntro:MHelpSkillsIntro = MHelpSkillsIntro()
        
        let items:[MHelpProtocol] = [
            itemIntro]
        
        super.init(items:items)
    }
}
