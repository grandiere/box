import Foundation
import CoreData

extension DSettings
{
    private static let kRangeRegular:Double = 200
    
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
    
    func currentDistance() -> MDistanceProtocol
    {
        let distance:MDistanceProtocol
        
        switch self.distance
        {
        case 1:
            
            distance = MDistanceFoot()
            
            break
            
        default:
            
            distance = MDistanceMetre()
            
            break
        }
        
        return distance
    }
    
    func changeDistance(distance:MDistanceProtocol)
    {
        if let _:MDistanceFoot = distance as? MDistanceFoot
        {
            self.distance = 1
        }
        else
        {
            self.distance = 0
        }
        
        DManager.sharedInstance?.save()
    }
}
