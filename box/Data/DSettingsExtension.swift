import Foundation
import CoreData

extension DSettings
{
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
}
