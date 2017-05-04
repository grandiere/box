import UIKit
import CoreLocation

class MGridVirus
{
    private weak var modelAlgo:MGridAlgo!
    let kEnergyRequired:Int16 = 85
    private let kUserLevelAdd:Int = 1
    
    init(modelAlgo:MGridAlgo)
    {
        self.modelAlgo = modelAlgo
    }
    
    //MARK: public
    
    func releaseVirus(userLocation:CLLocation) -> NSAttributedString?
    {
        guard
            
            let userLevel:Int16 = MSession.sharedInstance.settings?.user?.level
        
        else
        {
            return nil
        }
        
        let maxRandom:UInt32 = UInt32(userLevel)
        let random:UInt32 = arc4random_uniform(maxRandom)
        let virusLevel:Int = Int(random) + kUserLevelAdd
        modelAlgo.releaseVirus(virusLevel:virusLevel)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        return mutableString
    }
}
