import UIKit

class MGridAlgoAidItem:MGridAlgoItem
{
    private let kShowDownload:Bool = true
    
    init(
        firebaseId:String,
        firebaseAid:FDbAlgoAidItem)
    {
        super.init(
            firebaseId:firebaseId,
            latitude:firebaseAid.latitude,
            longitude:firebaseAid.longitude,
            created:firebaseAid.created)
    }
    
    //MARK: algo protocol

    override var algoTitle:String?
    {
        get
        {
            let title:String = NSLocalizedString("MGridAlgoItemAid_title", comment:"")
            
            return title
        }
    }
    
    override var firebasePath:String
    {
        get
        {
            let path:String = "\(FDb.algoAid)/\(firebaseId)"
            
            return path
        }
    }
    
    override var icon:UIImage?
    {
        get
        {
            return #imageLiteral(resourceName: "assetTextureAidDetail")
        }
    }
    
    override func detail() -> [MGridVisorDetailProtocol]
    {
        let itemHeader:MGridVisorDetailHeader = MGridVisorDetailHeader(model:self)
        let itemAge:MGridVisorDetailAge = MGridVisorDetailAge(model:self)
        
        let items:[MGridVisorDetailProtocol] = [
            itemHeader,
            itemAge]
        
        return items
    }
    
    //MARK: menu protocol
    
    override var showDownload:Bool
    {
        get
        {
            return kShowDownload
        }
    }
    
    //MARK: render protocol
    
    override var textureStandby:UIImage?
    {
        get
        {
            return #imageLiteral(resourceName: "assetTextureAidStandBy")
        }
    }
    
    override var textureTargeted:UIImage?
    {
        get
        {
            return #imageLiteral(resourceName: "assetTextureTarget00")
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
            return #imageLiteral(resourceName: "assetTextureAidAnnotationOn")
        }
    }
    
    override var annotationImageOff:UIImage?
    {
        get
        {
            return #imageLiteral(resourceName: "assetTextureAidAnnotationOff")
        }
    }
}
