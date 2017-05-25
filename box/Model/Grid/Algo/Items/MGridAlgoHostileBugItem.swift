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
    
    override var algoTitle:String?
    {
        get
        {
            let title:String = NSLocalizedString("MGridAlgoItemHostileBug_title", comment:"")
            
            return title
        }
    }
    
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
    
    override func detail() -> [MGridVisorDetailProtocol]
    {
        let items:[MGridVisorDetailProtocol] = []
        
        return items
    }
    
    //MARK: menu protocol
    
    override var showMatch:Bool
    {
        get
        {
            return kShowMatch
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
    
    override var overlayColour:UIColor
    {
        get
        {
            return UIColor.gridGreen
        }
    }
    
    //MARK: map protocol
    
    override var annotationImageOn:UIImage?
    {
        get
        {
            return #imageLiteral(resourceName: "assetTextureBugAnnotationOn")
        }
    }
    
    override var annotationImageOff:UIImage?
    {
        get
        {
            return #imageLiteral(resourceName: "assetTextureBugAnnotationOff")
        }
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
    
    override func destroySuccess()
    {
        MSession.sharedInstance.settings?.stats?.debugSuccess()
    }
}
