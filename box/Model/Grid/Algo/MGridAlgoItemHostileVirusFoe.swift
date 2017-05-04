import UIKit

class MGridAlgoItemHostileVirusFoe:MGridAlgoItemHostileVirus
{
    let userId:String
    private let kCreditsMultiplier:CGFloat = 2
    
    convenience init(
        firebaseId:String,
        firebaseVirus:FDbAlgoHostileVirusItem)
    {
        self.init(
            firebaseId:firebaseId,
            latitude:firebaseVirus.latitude,
            longitude:firebaseVirus.longitude,
            level:firebaseVirus.level,
            created:firebaseVirus.created,
            userId:firebaseVirus.userId)
    }
    
    init(
        firebaseId:String,
        latitude:Double,
        longitude:Double,
        level:Int,
        created:TimeInterval,
        userId:String)
    {
        self.userId = userId
        
        super.init(
            firebaseId:firebaseId,
            latitude:latitude,
            longitude:longitude,
            level:level,
            created:created)
    }
    
    override func creditsMultiplier() -> CGFloat
    {
        return kCreditsMultiplier
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
}
