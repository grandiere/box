import Foundation
import CoreData

extension DStats
{
    private static let kSuccessIncrease:Int16 = 1
    
    //MARK: public
    
    func debugSuccess()
    {
        bugs += DStats.kSuccessIncrease
        
        DManager.sharedInstance?.save()
    }
    
    func antivirusSuccess()
    {
        virus += DStats.kSuccessIncrease
        
        DManager.sharedInstance?.save()
    }
    
    func virusReleaseSuccess()
    {
        virusReleased += DStats.kSuccessIncrease
        
        DManager.sharedInstance?.save()
    }
}
