import Foundation

class MGridVisorDownload
{
    private static let kDifficultyStats:UInt32 = 80
    
    class func strategyDownload(item:MGridAlgoAidItem) -> MGridVisorDownloadProtocol?
    {
        let random:UInt32 = arc4random_uniform(kDifficultyStats)
        let strategy:MGridVisorDownloadProtocol?
        
        if random == 0
        {
            strategy = MGridVisorDownloadStats.factory()
        }
        else
        {
            strategy = MGridVisorDownloadEnergy.factory()
        }
        
        return strategy
    }
}
