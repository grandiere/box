import UIKit

class MGridAlgoItemHostileBug:MGridAlgoItemHostile
{
    private let kCreditsMultiplier:Int = 3
    
    init(latitude:Double, longitude:Double, level:Int, created:TimeInterval)
    {
        super.init(
            latitude:latitude,
            longitude:longitude,
            level:level,
            created:created,
            creditsMultiplier:kCreditsMultiplier)
    }
    
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
}
