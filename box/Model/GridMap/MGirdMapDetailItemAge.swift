import UIKit

class MGridMapDetailItemAge:MGridMapDetailItem
{
    init?(annotation:MGridMapAnnotation)
    {
        guard
            
            let created:TimeInterval = annotation.algo?.created
        
        else
        {
            return nil
        }
        
        let timestamp:TimeInterval = Date().timeIntervalSince1970
        let deltaTime:TimeInterval = timestamp - created
        let rawStringTime:String
        let twoHours:TimeInterval = kHour + kHour
        
        if deltaTime < twoHours
        {
            rawStringTime = NSLocalizedString("MGridMapDetailItemAge_justNow", comment:"")
        }
        else
        {
            let hoursSince:Int = Int(deltaTime / kHour)
            let hoursSinceNumber:NSNumber = hoursSince as NSNumber
            
            rawStringTime = String(
                format:NSLocalizedString("MGridMapDetailItemAge_hoursAgo", comment:""),
                hoursSinceNumber)
        }
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:14),
            NSForegroundColorAttributeName:UIColor(white:0, alpha:0.3)]
        let attributesSubtitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.numeric(size:14),
            NSForegroundColorAttributeName:UIColor.black]
        
        let stringTitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("MGridMapDetailItemAge_stringTitle", comment:""),
            attributes:attributesTitle)
        let stringTime:NSAttributedString = NSAttributedString(
            string:rawStringTime,
            attributes:attributesSubtitle)
        
        mutableString.append(stringTitle)
        mutableString.append(stringTime)
        
        super.init(attributedString:mutableString)
    }
}
