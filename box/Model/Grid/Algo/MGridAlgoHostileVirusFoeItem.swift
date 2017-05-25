import UIKit
import FirebaseDatabase

class MGridAlgoHostileVirusFoeItem:MGridAlgoItemHostileVirus
{
    let userId:String
    private let kCreditsMultiplier:CGFloat = 2
    private let kHarvestMultiplier:Int = 10
    private let kShowMatch:Bool = true
    
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
        { (mutableData:MutableData) -> (TransactionResult) in
            
            var newHarvestItem:FDbHarvestItem?
            
            if let currentHarvest:Any = mutableData.value
            {
                if let harvestItem:FDbHarvestItem = FDbHarvestItem(snapshot:currentHarvest)
                {
                    newHarvestItem = FDbHarvestItem(
                        score:harvestItem.score + score,
                        kills:harvestItem.kills + 1)
                }
            }
            
            if newHarvestItem == nil
            {
                newHarvestItem = FDbHarvestItem(
                    score:score,
                    kills:1)
            }
            
            let harvestJson:Any? = newHarvestItem?.json()
            mutableData.value = harvestJson
            
            let transactionResult:TransactionResult = TransactionResult.success(
                withValue:mutableData)
            
            return transactionResult
        }
    }
    
    override var showMatch:Bool
        {
        get
        {
            return kShowMatch
        }
    }
    
    //MARK: private
    
    private func harvestScore() -> Int
    {
        return level * kHarvestMultiplier
    }
    
    override func textureColour() -> UIColor
    {
        return UIColor.gridOrange
    }
}
