import Foundation

class MGridVisorTakeStatsSkill:MGridVisorTakeStats
{
    init()
    {
        let name:String = NSLocalizedString("MGridVisorTakeStatsSkill_name", comment:"")
        
        super.init(name:name)
    }
    
    override func apply(controller:CGridVisorTake)
    {
        super.apply(controller:controller)
        
        MSession.sharedInstance.settings?.stats.add
    }
}
