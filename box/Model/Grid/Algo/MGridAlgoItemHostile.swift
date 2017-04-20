import UIKit
import CoreLocation

class MGridAlgoItemHostile:MGridAlgoItem
{
    let level:Int
    private(set) var credits:Int
    let created:TimeInterval
    private let kTimeDivisor:TimeInterval = 36000
    private let kDistanceDivisor:CLLocationDistance = 10
    
    init(
        latitude:Double,
        longitude:Double,
        level:Int,
        created:TimeInterval)
    {
        self.level = level
        self.created = created
        credits = 0
        
        super.init(
            latitude:latitude,
            longitude:longitude)
    }
    
    override func distanceUser(userLocation:CLLocation)
    {
        super.distanceUser(userLocation:userLocation)
        updateCredits()
    }
    
    //MARK: private
    
    private func updateCredits()
    {
        guard
            
            let distance:CLLocationDistance = self.distance
        
        else
        {
            return
        }
        
        var credits:Int = level
        let timestamp:TimeInterval = Date().timeIntervalSince1970
        let deltaTime:TimeInterval = timestamp - created
        let timeDivided:TimeInterval = deltaTime / kTimeDivisor
        let distanceDivided:CLLocationDistance = distance / kDistanceDivisor
        let maxCredits:Int = Int(DEnergy.kMaxEnergy)
        credits += Int(timeDivided)
        credits += Int(distanceDivided)
        credits *= creditsMultiplier()
        
        if credits > maxCredits
        {
            credits = maxCredits
        }
        
        self.credits = credits
    }
    
    //MARK: public
    
    func creditsMultiplier() -> Int
    {
        return 0
    }
}
