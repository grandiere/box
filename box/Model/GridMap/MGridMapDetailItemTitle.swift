import UIKit

class MGridMapDetailItemTitle:MGridMapDetailItem
{
    init?(annotation:MGridMapAnnotation)
    {
        guard
        
            let rawTitle:String = annotation.algo?.titleAnnotation
        
        else
        {
            return nil
        }
        
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:18),
            NSForegroundColorAttributeName:UIColor.black,
            NSParagraphStyleAttributeName:paragraphStyle]
        
        let stringTitle:NSAttributedString = NSAttributedString(
            string:rawTitle,
            attributes:attributesTitle)
        
        super.init(attributedString:stringTitle)
    }
}
