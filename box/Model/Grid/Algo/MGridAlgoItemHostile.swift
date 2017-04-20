import UIKit

class MGridAlgoItemHostile:MGridAlgoItem
{
    let level:Int
    let created:TimeInterval
    
    init(
        latitude:Double,
        longitude:Double,
        level:Int,
        created:TimeInterval)
    {
        self.level = level
        self.created = created
        
        super.init(
            latitude:latitude,
            longitude:longitude)
    }
}
