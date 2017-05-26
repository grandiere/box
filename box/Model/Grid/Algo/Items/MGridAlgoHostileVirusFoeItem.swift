import UIKit
import FirebaseDatabase

class MGridAlgoHostileVirusFoeItem:MGridAlgoHostileVirusItem
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
    
    //MARK: private
    
    private func harvestScore() -> Int
    {
        return level * kHarvestMultiplier
    }
    
    //MARK: algo protocol
    
    override var algoTitle:String?
    {
        get
        {
            let title:String = NSLocalizedString("MGridAlgoItemHostileVirusFoe_title", comment:"")
            
            return title
        }
    }
    
    override var icon:UIImage?
    {
        get
        {
            return #imageLiteral(resourceName: "assetTextureVirusFoeDetail")
        }
    }
    
    override func detail() -> [MGridVisorDetailProtocol]
    {
        let itemHeader:MGridVisorDetailHeader = MGridVisorDetailHeader(model:self)
        let itemDistance:MGridVisorDetailDistance = MGridVisorDetailDistance(model:self)
        let itemKills:MGridVisorDetailKills = MGridVisorDetailKills(model:self)
        let itemCreator:MGridVisorDetailCreator = MGridVisorDetailCreator(model:self)
        let itemAge:MGridVisorDetailAge = MGridVisorDetailAge(model:self)
        
        let items:[MGridVisorDetailProtocol] = [
            itemHeader,
            itemDistance,
            itemKills,
            itemCreator,
            itemAge]
        
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
            return #imageLiteral(resourceName: "assetTextureVirusFoeStandBy")
        }
    }
    
    override var textureTargeted:UIImage?
    {
        get
        {
            return #imageLiteral(resourceName: "assetTextureVirusFoeTargeted")
        }
    }
    
    override var overlayColour:UIColor
    {
        get
        {
            return UIColor.gridOrange
        }
    }
    
    //MARK: map protocol
    
    override var annotationImageOn:UIImage?
    {
        get
        {
            return #imageLiteral(resourceName: "assetTextureVirusFoeAnnotationOn")
        }
    }
    
    override var annotationImageOff:UIImage?
    {
        get
        {
            return #imageLiteral(resourceName: "assetTextureVirusFoeAnnotationOff")
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
            let title:String = NSLocalizedString("MGridAlgoItemHostileVirusFoe_titleMatch", comment:"")
            
            return title
        }
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
}
