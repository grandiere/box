import UIKit

class MGridAlgoItemHostile:MGridAlgoItem
{
    let level:Int
    let credits:Int
    let created:TimeInterval
    private let kTimeDivisor:TimeInterval = 3600
    
    init(
        latitude:Double,
        longitude:Double,
        level:Int,
        created:TimeInterval,
        creditsMultiplier:Int)
    {
        self.level = level
        self.created = created
        
        var credits:Int = 0
        let timestamp:TimeInterval = Date().timeIntervalSince1970
        let deltaTime:TimeInterval = timestamp - created
        let timeDivided:TimeInterval = deltaTime / kTimeDivisor
        let levelMultiplied:Int = level + creditsMultiplier
        let maxCredits:Int = Int(DEnergy.kMaxEnergy)
        credits += Int(timeDivided)
        credits += levelMultiplied
        
        if credits > maxCredits
        {
            credits = maxCredits
        }
        
        self.credits = credits
        
        super.init(
            latitude:latitude,
            longitude:longitude)
    }
}
