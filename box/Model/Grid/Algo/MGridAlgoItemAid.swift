import UIKit

class MGridAlgoItemAid:MGridAlgoItem
{
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
        let model:MGridVisorDetail = MGridVisorDetail.detailAid(model:self)
        
        return model
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
        let title:String = NSLocalizedString("MGridAlgoItemAid_titleMatch", comment:"")
        
        return title
    }
    
    override func titleAnnotation() -> String?
    {
        let title:String = NSLocalizedString("MGridAlgoItemAid_titleAnnotation", comment:"")
        
        return title
    }
}
