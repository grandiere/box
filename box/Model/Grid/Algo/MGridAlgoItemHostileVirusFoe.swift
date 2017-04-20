import UIKit

class MGridAlgoItemHostileVirusFoe:MGridAlgoItemHostileVirus
{
    let posterId:String
    private let kCreditsMultiplier:Int = 5
    
    init(
        latitude:Double,
        longitude:Double,
        level:Int,
        created:TimeInterval,
        posterId:String)
    {
        self.posterId = posterId
        
        super.init(
            latitude:latitude,
            longitude:longitude,
            level:level,
            created:created)
    }
    
    override func creditsMultiplier() -> Int
    {
        return kCreditsMultiplier
    }
}
