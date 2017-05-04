import Foundation

class MGridVisorTakeStatsProcessor:MGridVisorTakeStats
{
    init()
    {
        let name:String = NSLocalizedString("MGridVisorTakeStatsProcessor_name", comment:"")
        
        super.init(name:name)
    }
    
    override func apply(controller:CGridVisorTake)
    {
        super.apply(controller:controller)
        
        MSession.sharedInstance.settings?.user?.addMemory()
    }
}
