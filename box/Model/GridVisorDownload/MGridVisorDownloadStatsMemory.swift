import Foundation

class MGridVisorDownloadStatsMemory:MGridVisorDownloadStats
{
    init()
    {
        let name:String = NSLocalizedString("MGridVisorDownloadStatsMemory_name", comment:"")
        
        super.init(name:name)
    }
    
    override func apply()
    {
        MSession.sharedInstance.settings?.user?.addMemory()
    }
}
