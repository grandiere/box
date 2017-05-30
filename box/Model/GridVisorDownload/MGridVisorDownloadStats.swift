import UIKit

class MGridVisorDownloadStats:MGridVisorDownloadProtocol
{
    private let attributedString:NSAttributedString
    private let kValueFontSize:CGFloat = 38
    private let kNameFontSize:CGFloat = 22
    
    class func factory() -> MGridVisorDownloadStats
    {
        let newStats:MGridVisorDownloadStats
        
        let random:UInt32 = arc4random_uniform(4)
        
        switch random
        {
        case 1:
            
            newStats = MGridVisorDownloadStatsMemory()
            
            break
            
        case 2:
            
            newStats = MGridVisorDownloadStatsNetwork()
            
            break
            
        case 3:
            
            newStats = MGridVisorDownloadStatsProcessor()
            
            break
            
        default:
            
            newStats = MGridVisorDownloadStatsSkill()
            
            break
        }
        
        return newStats
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
            string:NSLocalizedString("MGridVisorDownloadStats_stringValue", comment:""),
            attributes:attributesValue)
        let stringName:NSAttributedString = NSAttributedString(
            string:name,
            attributes:attributesName)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringValue)
        mutableString.append(stringName)
        
        attributedString = mutableString
    }
    
    //MARK: download protocol
    
    var descr:NSAttributedString
    {
        get
        {
            return attributedString
        }
    }
    
    func apply(controller:CGridVisorDownload)
    {
        controller.destroyAid()
    }
}
