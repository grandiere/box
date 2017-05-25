import UIKit

class MGridAlgoHostileBugItem:MGridAlgoHostileItem
{
    private let kCreditsMultiplier:CGFloat = 1.5
    private let kShowMatch:Bool = true
    
    init(
        firebaseId:String,
        firebaseBug:FDbAlgoHostileBugItem)
    {
        super.init(
            firebaseId:firebaseId,
            latitude:firebaseBug.latitude,
            longitude:firebaseBug.longitude,
            level:firebaseBug.level,
            defeated:firebaseBug.defeated,
            created:firebaseBug.created)
    }
    
    //MARK: algo protocol
    
    /*
    override func firebasePath() -> String
    {
        let path:String = "\(FDb.algoBug)/\(firebaseId)"
        
        return path
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
    
    override func destroySuccess()
    {
        MSession.sharedInstance.settings?.stats?.debugSuccess()
    }
    
    override func textureColour() -> UIColor
    {
        return UIColor.gridGreen
    }
    
    override var showMatch:Bool
        {
        get
        {
            return kShowMatch
        }
    }*/
}
