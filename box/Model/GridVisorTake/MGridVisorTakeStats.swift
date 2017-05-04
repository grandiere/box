import UIKit

class MGridVisorTakeStats:MGridVisorTakeProtocol
{
    private let attributedString:NSAttributedString
    private let kValueFontSize:CGFloat = 34
    private let kNameFontSize:CGFloat = 22
    
    class func factory() -> MGridVisorTakeStats
    {
        let energyLevel:MGridVisorTakeEnergy
        
        let random:UInt32 = arc4random_uniform(10)
        
        switch random
        {
        case 1:
            
            energyLevel = MGridVisorTakeEnergy20()
            
            break
            
        default:
            
            energyLevel = MGridVisorTakeEnergy15()
            
            break
        }
        
        return energyLevel
    }
    
    init(name:String)
    {
        let attributesValue:[String:AnyObject] = [
            NSFontAttributeName:UIFont.numeric(size:kValueFontSize),
            NSForegroundColorAttributeName:UIColor.gridBlue]
        
        let attributesName:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:kNameFontSize),
            NSForegroundColorAttributeName:UIColor.black]
        
        let stringValue:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("MGridVisorTakeStats_stringValue", comment:""),
            attributes:attributesValue)
        let stringName:NSAttributedString = NSAttributedString(
            string:name,
            attributes:attributesName)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringValue)
        mutableString.append(stringName)
        
        attributedString = mutableString
    }
    
    //MARK: visorTake protocol
    
    var descr:NSAttributedString
    {
        get
        {
            return attributedString
        }
    }
    
    func apply(controller:CGridVisorTake)
    {
        controller.destroyAid()
    }
}
