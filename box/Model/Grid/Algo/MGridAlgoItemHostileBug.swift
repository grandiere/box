import UIKit

class MGridAlgoItemHostileBug:MGridAlgoItemHostile
{
    private let kCreditsMultiplier:Int = 3
    
    override func imageStandby() -> UIImage?
    {
        return #imageLiteral(resourceName: "assetTextureBugStandBy")
    }
    
    override func imageTargeted() -> UIImage?
    {
        return #imageLiteral(resourceName: "assetTextureBugTargeted")
    }
    
    override func imageDetail() -> UIImage?
    {
        return #imageLiteral(resourceName: "assetTextureBugDetail")
    }
    
    override func detail() -> MGridVisorDetail
    {
        let model:MGridVisorDetail = MGridVisorDetail.detailBug(model:self)
        
        return model
    }
    
    override func creditsMultiplier() -> Int
    {
        return kCreditsMultiplier
    }
}
