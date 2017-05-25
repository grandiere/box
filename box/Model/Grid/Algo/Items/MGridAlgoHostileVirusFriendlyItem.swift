import UIKit

class MGridAlgoHostileVirusFriendlyItem:MGridAlgoHostileVirusItem
{
    init(
        firebaseId:String,
        firebaseVirus:FDbAlgoHostileVirusItem)
    {
        super.init(
            firebaseId:firebaseId,
            latitude:firebaseVirus.latitude,
            longitude:firebaseVirus.longitude,
            level:firebaseVirus.level,
            defeated:firebaseVirus.defeated,
            created:firebaseVirus.created)
    }
    
    //MARK: algo protocol
    
    override var icon:UIImage?
    {
        get
        {
            return #imageLiteral(resourceName: "assetTextureVirusFriendlyDetail")
        }
    }
    
    override func detail() -> [MGridVisorDetailProtocol]
    {
        let items:[MGridVisorDetailProtocol] = []
        
        return items
    }
    
    //MARK: render protocol
    
    override var textureStandby:UIImage?
    {
        get
        {
            return #imageLiteral(resourceName: "assetTextureVirusFriendlyStandBy")
        }
    }
    
    override var textureTargeted:UIImage?
    {
        get
        {
            return #imageLiteral(resourceName: "assetTextureVirusFriendlyTargeted")
        }
    }
    
    override var overlayColour:UIColor
    {
        get
        {
            return UIColor.gridBlue
        }
    }
    
    //MARK: map protocol
    
    override var annotationImageOn:UIImage?
    {
        get
        {
            return #imageLiteral(resourceName: "assetTextureVirusFriendlyAnnotationOn")
        }
    }
    
    override var annotationImageOff:UIImage?
    {
        get
        {
            return #imageLiteral(resourceName: "assetTextureVirusFriendlyAnnotationOff")
        }
    }
    
    override var annotationTitle:String?
    {
        get
        {
            let title:String = NSLocalizedString("MGridAlgoItemHostileVirusFriendly_titleAnnotation", comment:"")
            
            return title
        }
    }
}
