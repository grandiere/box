import UIKit

class MGridAlgoItemHostile:MGridAlgoItem
{
    let difficulty:Int
    let created:TimeInterval
    
    init(
        latitude:Double,
        longitude:Double,
        difficulty:Int,
        created:TimeInterval)
    {
        self.difficulty = difficulty
        self.created = created
        
        super.init(
            latitude:latitude,
            longitude:longitude)
    }
}
