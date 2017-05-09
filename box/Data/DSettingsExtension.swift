import Foundation
import CoreData

extension DSettings
{
    enum Distance:Int16
    {
        case meters = 0
        case miles = 1
    }
    
    private static let kRangeRegular:Double = 500
    
    //MARK: public
    
    func addTtl()
    {
        ttl += 1
        DManager.sharedInstance?.save()
    }
    
    func visorRange() -> Double
    {
        var range:Double = DSettings.kRangeRegular
        
        if plusRange
        {
            range += range
        }
        
        return range
    }
    
    func currentDistance() -> Distance
    {
        guard
        
            let distance:Distance = Distance(rawValue:self.distance)
        
        else
        {
            return Distance.meters
        }
        
        return distance
    }
}
