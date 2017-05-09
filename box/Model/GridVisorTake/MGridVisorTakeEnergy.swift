import UIKit

class MGridVisorTakeEnergy:MGridVisorTakeProtocol
{
    private let energyAmount:Int16
    private let attributedString:NSAttributedString
    private let kValueFontSize:CGFloat = 34
    private let kNameFontSize:CGFloat = 16
    
    class func factory() -> MGridVisorTakeEnergy
    {
        let energyLevel:MGridVisorTakeEnergy
        
        let random:UInt32 = arc4random_uniform(11)
        
        switch random
        {
        case 1:
            
            energyLevel = MGridVisorTakeEnergy20()
            
            break
            
        case 2:
            
            energyLevel = MGridVisorTakeEnergy25()
            
            break
            
        case 3:
            
            energyLevel = MGridVisorTakeEnergy30()
            
            break
            
        default:
            
            energyLevel = MGridVisorTakeEnergy15()
            
            break
        }
        
        return energyLevel
    }
    
    init(energyAmount:Int16)
    {
        self.energyAmount = energyAmount
        
        let attributesValue:[String:AnyObject] = [
            NSFontAttributeName:UIFont.numeric(size:kValueFontSize),
            NSForegroundColorAttributeName:UIColor.gridBlue]
        
        let attributesName:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:kNameFontSize),
            NSForegroundColorAttributeName:UIColor.black]
        
        let amountAsNumber:NSNumber = energyAmount as NSNumber
        let amountString:String = String(
            format:NSLocalizedString("MGridVisorTakeEnergy_stringValue", comment:""),
            amountAsNumber)
        
        let stringValue:NSAttributedString = NSAttributedString(
            string:amountString,
            attributes:attributesValue)
        let stringName:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("MGridVisorTakeEnergy_stringName", comment:""),
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
        MSession.sharedInstance.settings?.energy?.addEnergy(energyAmount:energyAmount)
        controller.destroyAid()
    }
}
