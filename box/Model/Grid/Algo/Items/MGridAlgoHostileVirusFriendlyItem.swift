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
    
    override var algoTitle:String?
    {
        get
        {
            let title:String = NSLocalizedString("MGridAlgoItemHostileVirusFriendly_title", comment:"")
            
            return title
        }
    }
    
    override var icon:UIImage?
    {
        get
        {
            return #imageLiteral(resourceName: "assetTextureVirusFriendlyDetail")
        }
    }
    
    override func detail() -> [MGridVisorDetailProtocol]
    {
        let itemHeader:MGridVisorDetailHeader = MGridVisorDetailHeader(model:self)
        let itemLevel:MGridVisorDetailLevel = MGridVisorDetailLevel(model:self)
        let itemDistance:MGridVisorDetailDistance = MGridVisorDetailDistance(model:self)
        let itemKills:MGridVisorDetailKills = MGridVisorDetailKills(model:self)
        let itemAge:MGridVisorDetailAge = MGridVisorDetailAge(model:self)
        
        let items:[MGridVisorDetailProtocol] = [
            itemHeader,
            itemLevel,
            itemDistance,
            itemKills,
            itemAge]
        
        return items
    }
    
    //MARK: render protocol
    
    override func textureStandby(textures:MGridVisorRenderTextures) -> MTLTexture?
    {
        return textures.standbyVirusFriendly
    }
    
    override func textureTargeted(textures:MGridVisorRenderTextures) -> MTLTexture?
    {
        return textures.targetedVirusFriendly.current()
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
}
