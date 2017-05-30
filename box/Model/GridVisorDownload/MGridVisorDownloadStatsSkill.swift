import Foundation

class MGridVisorDownloadStatsSkill:MGridVisorDownloadStats
{
    init()
    {
        let name:String = NSLocalizedString("MGridVisorDownloadStatsSkill_name", comment:"")
        
        super.init(name:name)
    }
    
    override func apply(controller:CGridVisorDownload)
    {
        super.apply(controller:controller)
        
        MSession.sharedInstance.settings?.user?.addSkill()
    }
}
