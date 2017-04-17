import Foundation
import CoreLocation

class MGridAlgoItemHostileVirusFoe:MGridAlgoItemHostileVirus
{
    let posterId:String
    
    init(
        latitude:Double,
        longitude:Double,
        difficulty:Int,
        created:TimeInterval,
        posterId:String)
    {
        self.posterId = posterId
        super.init(
            latitude:latitude,
            longitude:longitude,
            difficulty:difficulty,
            created:created)
    }
}
