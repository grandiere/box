import Foundation

class MGridVisorTakeStatsNetwork:MGridVisorTakeStats
{
    init()
    {
        let name:String = NSLocalizedString("MGridVisorTakeStatsNetwork_name", comment:"")
        
        super.init(name:name)
    }
    
    override func apply(controller:CGridVisorTake)
    {
        super.apply(controller:controller)
        
        MSession.sharedInstance.settings?.user?.addMemory()
    }
}
