import UIKit

class MGridAlgoItemHostileVirusFoe:MGridAlgoItemHostileVirus
{
    let posterId:String
    
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
}
