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
            
            let userId:String = MSession.sharedInstance.settings?.firebaseId,
            let userLevel:Int16 = MSession.sharedInstance.settings?.user?.level
        
        else
        {
            return nil
        }
        
        let maxRandom:UInt32 = UInt32(userLevel)
        let random:UInt32 = arc4random_uniform(maxRandom)
        let virusLevel:Int = Int(random) + kUserLevelAdd
        
        modelAlgo.factory.releaseVirus(
            userId:userId,
            location:userLocation,
            level:virusLevel)
        
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:16),
            NSForegroundColorAttributeName:UIColor(white:1, alpha:0.7)]
        let attributesLevel:[String:AnyObject] = [
            NSFontAttributeName:UIFont.numeric(size:40),
            NSForegroundColorAttributeName:UIColor.white]
        let levelString:String = "\(virusLevel)"
        
        let stringTitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("MGridVirus_labelTitle", comment:""),
            attributes:attributesTitle)
        let stringLevel:NSAttributedString = NSAttributedString(
            string:levelString,
            attributes:attributesLevel)
        let stringSubtitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("MGridVirus_labelSubtitle", comment:""),
            attributes:attributesTitle)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringTitle)
        mutableString.append(stringLevel)
        mutableString.append(stringSubtitle)
        
        return mutableString
    }
}
