import Foundation

class MGridVisorDownloadStatsProcessor:MGridVisorDowbloadStats
{
    init()
    {
        let name:String = NSLocalizedString("MGridVisorDownloadStatsProcessor_name", comment:"")
        
        super.init(name:name)
    }
    
    override func apply(controller:CGridVisorDownload)
    {
        super.apply(controller:controller)
        
        MSession.sharedInstance.settings?.user?.addMemory()
    }
}
