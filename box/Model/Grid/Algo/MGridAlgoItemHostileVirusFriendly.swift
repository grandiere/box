import UIKit

class MGridAlgoItemHostileVirusFriendly:MGridAlgoItemHostile
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
}
