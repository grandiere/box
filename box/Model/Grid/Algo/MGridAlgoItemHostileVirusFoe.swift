import UIKit
import FirebaseDatabase

class MGridAlgoItemHostileVirusFoe:MGridAlgoItemHostileVirus
{
    let userId:String
    private let kCreditsMultiplier:CGFloat = 2
    private let kHarvestMultiplier:Int = 10
    
    convenience init(
        firebaseId:String,
        firebaseVirus:FDbAlgoHostileVirusItem)
    {
        self.init(
            firebaseId:firebaseId,
            latitude:firebaseVirus.latitude,
            longitude:firebaseVirus.longitude,
            level:firebaseVirus.level,
            defeated:firebaseVirus.defeated,
            created:firebaseVirus.created,
            userId:firebaseVirus.userId)
    }
    
    init(
        firebaseId:String,
        latitude:Double,
        longitude:Double,
        level:Int,
        defeated:Int,
        created:TimeInterval,
        userId:String)
    {
        self.userId = userId
        
        super.init(
            firebaseId:firebaseId,
            latitude:latitude,
            longitude:longitude,
            level:level,
            defeated:defeated,
            created:created)
    }
    
    override func creditsMultiplier() -> CGFloat
    {
        return kCreditsMultiplier
    }
    
    override func detail() -> MGridVisorDetail
    {
        let model:MGridVisorDetail = MGridVisorDetail.detailVirusFoe(model:self)
        
        return model
    }
    
    override func imageStandby() -> UIImage?
    {
        return #imageLiteral(resourceName: "assetTextureVirusFoeStandBy")
    }
    
    override func imageTargeted() -> UIImage?
    {
        return #imageLiteral(resourceName: "assetTextureVirusFoeTargeted")
    }
    
    override func imageDetail() -> UIImage?
    {
        return #imageLiteral(resourceName: "assetTextureVirusFoeDetail")
    }
    
    override func annotationImageOn() -> UIImage?
    {
        return #imageLiteral(resourceName: "assetTextureVirusFoeAnnotationOn")
    }
    
    override func annotationImageOff() -> UIImage?
    {
        return #imageLiteral(resourceName: "assetTextureVirusFoeAnnotationOff")
    }
    
    override func titleMatch() -> String?
    {
        let title:String = NSLocalizedString("MGridAlgoItemHostileVirusFoe_titleMatch", comment:"")
        
        return title
    }
    
    override func titleAnnotation() -> String?
    {
        let title:String = NSLocalizedString("MGridAlgoItemHostileVirusFoe_titleAnnotation", comment:"")
        
        return title
    }
    
    override func destroySuccess()
    {
        MSession.sharedInstance.settings?.stats?.antivirusSuccess()
    }
    
    override func addDefeated()
    {
        super.addDefeated()
        
        let score:Int = harvestScore()
        
        let path:String = "\(FDb.harvest)/\(userId)"
        FMain.sharedInstance.db.transaction(
            path:path)
        { (mutableData:FIRMutableData) -> (FIRTransactionResult) in
            
            guard
            
                let currentHarvest:Any = mutableData.value,
                let harvestItem:FDbHarvestItem = FDbHarvestItem(snapshot:currentHarvest)
            
            else
            {
                return
            }
            
            
        }
        
        FMain.sharedInstance.database.transaction(
            path:path)
        { (mutableData:FIRMutableData) -> (FIRTransactionResult) in
            
            if let currentLikes:Int = mutableData.value as? Int
            {
                let newLikes:Int = currentLikes + deltaLike
                mutableData.value = newLikes
            }
            else
            {
                if deltaLike > 0
                {
                    mutableData.value = deltaLike
                }
                else
                {
                    mutableData.value = 0
                }
            }
            
            let transationResult:FIRTransactionResult = FIRTransactionResult.success(
                withValue:mutableData)
            
            return transationResult
        }
        
        let path:String = "\(firebasePath())/\(FDbAlgoHostileItem.defeated)"
        FMain.sharedInstance.db.updateChild(
            path:path,
            json:defeated)
    }
    
    //MARK: private
    
    private func harvestScore() -> Int
    {
        return level * kHarvestMultiplier
    }
}
