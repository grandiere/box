import Foundation

class MGridVisorDownloadStatsSkill:MGridVisorDownloadStats
{
    init()
    {
        let name:String = NSLocalizedString("MGridVisorDownloadStatsSkill_name", comment:"")
        
        super.init(name:name)
    }
    
    override func apply()
    {
        MSession.sharedInstance.settings?.user?.addSkill()
    }
}
