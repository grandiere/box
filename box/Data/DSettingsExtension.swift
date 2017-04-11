import Foundation
import CoreData

extension DSettings
{
    //MARK: public
    
    func addTtl()
    {
        ttl += 1
        DManager.sharedInstance?.save()
    }
}
