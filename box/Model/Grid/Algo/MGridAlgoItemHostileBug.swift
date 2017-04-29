import UIKit

class MGridAlgoItemHostileBug:MGridAlgoItemHostile
{
    private let kCreditsMultiplier:CGFloat = 1.5
    
    init(
        firebaseId:String,
        firebaseBug:FDbAlgoHostileBugItem)
    {
        super.init(
            firebaseId:firebaseId,
            latitude:firebaseBug.latitude,
            longitude:firebaseBug.longitude,
            level:firebaseBug.level,
            created:firebaseBug.created)
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
    
    override func creditsMultiplier() -> CGFloat
    {
        return kCreditsMultiplier
    }
    
    override func annotationImageOn() -> UIImage?
    {
        return #imageLiteral(resourceName: "assetTextureBugAnnotationOn")
    }
    
    override func annotationImageOff() -> UIImage?
    {
        return #imageLiteral(resourceName: "assetTextureBugAnnotationOff")
    }
    
    override func titleMatch() -> String?
    {
        let title:String = NSLocalizedString("MGridAlgoItemHostileBug_titleMatch", comment:"")
        
        return title
    }
    
    override func titleAnnotation() -> String?
    {
        let title:String = NSLocalizedString("MGridAlgoItemHostileBug_titleAnnotation", comment:"")
        
        return title
    }
}
