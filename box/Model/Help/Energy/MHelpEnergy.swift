import Foundation

class MHelpEnergy:MHelp
{
    init()
    {
        let itemIntro:MHelpEnergyIntro = MHelpEnergyIntro()
        let itemTime:MHelpEnergyTime = MHelpEnergyTime()
        let itemAids:MHelpEnergyAids = MHelpEnergyAids()
        let itemPurchase:MHelpEnergyPurchase = MHelpEnergyPurchase()
        
        let items:[MHelpProtocol] = [
            itemIntro,
            itemTime,
            itemAids,
            itemPurchase]
        
        super.init(items:items)
    }
}
