import Foundation

class MGridVisorDownloadStatsProcessor:MGridVisorDownloadStats
{
    init()
    {
        let name:String = NSLocalizedString("MGridVisorDownloadStatsProcessor_name", comment:"")
        
        super.init(name:name)
    }
    
    override func apply()
    {
        MSession.sharedInstance.settings?.user?.addMemory()
    }
}
