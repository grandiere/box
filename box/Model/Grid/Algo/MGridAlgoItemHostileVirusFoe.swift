import UIKit

class MGridAlgoItemHostileVirusFoe:MGridAlgoItemHostileVirus
{
    let userId:String
    private let kCreditsMultiplier:CGFloat = 2
    
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
    
    override func destroySuccess()
    {
        MSession.sharedInstance.settings?.stats?.antivirusSuccess()
    }
}
