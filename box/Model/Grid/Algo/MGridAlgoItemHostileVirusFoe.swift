import UIKit

class MGridAlgoItemHostileVirusFoe:MGridAlgoItemHostileVirus
{
    let posterId:String
    private let kCreditsMultiplier:CGFloat = 2
    
    init(
        firebaseId:String,
        latitude:Double,
        longitude:Double,
        level:Int,
        created:TimeInterval,
        posterId:String)
    {
        self.posterId = posterId
        
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
}
