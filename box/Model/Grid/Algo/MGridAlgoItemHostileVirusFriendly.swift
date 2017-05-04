import UIKit

class MGridAlgoItemHostileVirusFriendly:MGridAlgoItemHostile
{
    override func imageStandby() -> UIImage?
    {
        return #imageLiteral(resourceName: "assetTextureVirusFriendlyStandBy")
    }
    
    override func imageTargeted() -> UIImage?
    {
        return #imageLiteral(resourceName: "assetTextureVirusFriendlyTargeted")
    }
    
    override func imageDetail() -> UIImage?
    {
        return #imageLiteral(resourceName: "assetTextureVirusFriendlyDetail")
    }
}
