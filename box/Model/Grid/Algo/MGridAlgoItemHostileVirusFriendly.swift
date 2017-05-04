import UIKit

class MGridAlgoItemHostileVirusFriendly:MGridAlgoItemHostileVirus
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
            created:firebaseVirus.created)
    }
    
    override func detail() -> MGridVisorDetail
    {
        let model:MGridVisorDetail = MGridVisorDetail.detailVirusFriendly(model:self)
        
        return model
    }
    
    override func imageStandby() -> UIImage?
    {
        return #imageLiteral(resourceName: "assetTextureVirusFriendlyStandBy")
    }
    
    override func imageTargeted() -> UIImage?
    {
        return #imageLiteral(resourceName: "assetTextureVirusFriendlyTargeted")
    }
    
    override func imageDetail() -> UIImage?
    {
        return #imageLiteral(resourceName: "assetTextureVirusFriendlyDetail")
    }
    
    override func annotationImageOn() -> UIImage?
    {
        return #imageLiteral(resourceName: "assetTextureVirusFriendlyAnnotationOn")
    }
    
    override func annotationImageOff() -> UIImage?
    {
        return #imageLiteral(resourceName: "assetTextureVirusFriendlyAnnotationOff")
    }
    
    override func titleAnnotation() -> String?
    {
        let title:String = NSLocalizedString("MGridAlgoItemHostileVirusFriendly_titleAnnotation", comment:"")
        
        return title
    }
}
