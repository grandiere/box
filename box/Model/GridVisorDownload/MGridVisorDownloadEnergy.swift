import UIKit

class MGridVisorDownloadEnergy:MGridVisorDownloadProtocol
{
    private let energyAmount:Int16
    private let attributedString:NSAttributedString
    private let kValueFontSize:CGFloat = 34
    private let kNameFontSize:CGFloat = 16
    private static let kResourceName:String = "ResourceDownloadEnergy"
    private static let kResourceExtension:String = "plist"
    
    class func factory() -> MGridVisorDownloadEnergy?
    {
        guard
            
            let resourceEnergy:URL = Bundle.main.url(
                forResource:kResourceName,
                withExtension:kResourceExtension),
            let energyArray:NSArray = NSArray(
                contentsOf:resourceEnergy),
            let energyList:[Int] = energyArray as? [Int]
            
        else
        {
            return nil
        }
        
        let countItems:UInt32 = UInt32(energyList.count)
        let randomItem:Int = Int(arc4random_uniform(countItems))
        let energyLevel:MGridVisorDownloadEnergy = MGridVisorDownloadEnergy(
            energyAmount:randomItem)
        
        return energyLevel
    }
    
    private init(energyAmount:Int)
    {
        self.energyAmount = Int16(energyAmount)
        
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
