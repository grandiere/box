import Foundation

class MGridVisorDownloadStatsNetwork:MGridVisorDownloadStats
{
    init()
    {
        let name:String = NSLocalizedString("MGridVisorDownloadStatsNetwork_name", comment:"")
        
        super.init(name:name)
    }
    
    override func apply()
    {
        MSession.sharedInstance.settings?.user?.addMemory()
    }
}
