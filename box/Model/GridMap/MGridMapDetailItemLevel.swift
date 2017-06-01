import UIKit

class MGridMapDetailItemLevel:MGridMapDetailItem
{
    init?(annotation:MGridMapAnnotation)
    {
        guard
        
            let algoHostile:MGridAlgoHostileItem = annotation.algo as? MGridAlgoHostileItem
        
        else
        {
            return nil
        }
        
        let level:NSNumber = algoHostile.level as NSNumber
        let numberFormatter:NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        guard
            
            let rawStringLevel:String = numberFormatter.string(from:level)
        
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
            string:NSLocalizedString("MGridMapDetailItemLevel_stringTitle", comment:""),
            attributes:attributesTitle)
        let stringLevel:NSAttributedString = NSAttributedString(
            string:rawStringLevel,
            attributes:attributesSubtitle)
        
        mutableString.append(stringTitle)
        mutableString.append(stringLevel)
        
        super.init(attributedString:mutableString)
    }
}
