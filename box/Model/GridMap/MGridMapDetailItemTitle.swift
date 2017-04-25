import UIKit

class MGridMapDetailItemTitle:MGridMapDetailItem
{
    init?(annotation:MGridMapAnnotation)
    {
        guard
        
            let rawTitle:String = annotation.algo.titleAnnotation()
        
        else
        {
            return nil
        }
        
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:20),
            NSForegroundColorAttributeName:UIColor.black]
        
        let stringTitle:NSAttributedString = NSAttributedString(
            string:rawTitle,
            attributes:attributesTitle)
        
        super.init(attributedString:stringTitle)
    }
}
