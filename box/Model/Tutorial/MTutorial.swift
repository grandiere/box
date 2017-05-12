import Foundation

class MTutorial
{
    let items:[MTutorialProtocol]
    
    init()
    {
        let itemBasic:MTutorialBasic = MTutorialBasic()
        let itemDebug:MTutorialDebug = MTutorialDebug()
        let itemAntivirus:MTutorialAntivirus = MTutorialAntivirus()
        let itemRelease:MTutorialRelease = MTutorialRelease()
        let itemEnergy:MTutorialEnergy = MTutorialEnergy()
        let itemSkills:MTutorialSkills = MTutorialSkills()
        
        items = [
            itemBasic,
            itemDebug,
            itemAntivirus,
            itemRelease,
            itemEnergy,
            itemSkills]
    }
}
