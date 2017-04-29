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
        return #imageLiteral(resourceName: "assetTextureAidStandBy")
    }
    
    override func imageTargeted() -> UIImage?
    {
        return #imageLiteral(resourceName: "assetTextureAidTargeted")
    }
    
    override func imageDetail() -> UIImage?
    {
        return #imageLiteral(resourceName: "assetTextureAidDetail")
    }
    
    override func detail() -> MGridVisorDetail
    {
        let model:MGridVisorDetail = MGridVisorDetail.detailAid(model:self)
        
        return model
    }
    
    override func annotationImageOn() -> UIImage?
    {
        return #imageLiteral(resourceName: "assetTextureAidAnnotationOn")
    }
    
    override func annotationImageOff() -> UIImage?
    {
        return #imageLiteral(resourceName: "assetTextureAidAnnotationOff")
    }
    
    override func titleAnnotation() -> String?
    {
        let title:String = NSLocalizedString("MGridAlgoItemAid_titleAnnotation", comment:"")
        
        return title
    }
}
