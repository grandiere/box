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
    
    //MARK: match protocol
    
    override var creditsMultiplier:CGFloat
    {
        get
        {
            return kCreditsMultiplier
        }
    }
    
    override var matchTitle:String?
    {
        get
        {
            let title:String = NSLocalizedString("MGridAlgoItemHostileBug_titleMatch", comment:"")
            
            return title
        }
    }
    
    //MARK: algo protocol
    
    override var firebasePath:String
    {
        get
        {
            let path:String = "\(FDb.algoBug)/\(firebaseId)"
            
            return path
        }
    }
    
    override var icon:UIImage?
    {
        get
        {
            return #imageLiteral(resourceName: "assetTextureBugDetail")
        }
    }
    
    //MARK: render protocol
    
    override var textureStandby:UIImage?
    {
        get
        {
            return #imageLiteral(resourceName: "assetTextureBugStandBy")
        }
    }
    
    override var textureTargeted:UIImage?
    {
        get
        {
            return #imageLiteral(resourceName: "assetTextureBugTargeted")
        }
    }
    
    /*
    
    
    
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
