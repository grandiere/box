import Foundation

class MGridVisorDownloadStatsMemory:MGridVisorDownloadStats
{
    init()
    {
        let name:String = NSLocalizedString("MGridVisorDownloadStatsMemory_name", comment:"")
        
        super.init(name:name)
    }
    
    override func apply(controller:CGridVisorDownload)
    {
        super.apply(controller:controller)
        
        MSession.sharedInstance.settings?.user?.addMemory()
    }
}
