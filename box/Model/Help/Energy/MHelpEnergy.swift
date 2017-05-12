import Foundation

class MHelpEnergy:MHelp
{
    init()
    {
        let itemIntro:MHelpEnergyIntro = MHelpEnergyIntro()
        let itemTime:MHelpEnergyTime = MHelpEnergyTime()
        let itemAids:MHelpEnergyAids = MHelpEnergyAids()
        
        let items:[MHelpProtocol] = [
            itemIntro,
            itemTime,
            itemAids]
        
        super.init(items:items)
    }
}
