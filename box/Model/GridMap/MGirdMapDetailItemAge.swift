import UIKit

class MGridMapDetailItemAge:MGridMapDetailItem
{
    init?(annotation:MGridMapAnnotation)
    {
        guard
            
            let rawStringTime:String = annotation.algo?.age()
        
        else
        {
            return nil
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
