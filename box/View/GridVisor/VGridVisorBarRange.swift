import UIKit

class VGridVisorBarRange:UIView
{
    private weak var controller:CGridVisor!
    
    init(controller:CGridVisor)
    {
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:13),
            NSForegroundColorAttributeName:UIColor(white:1, alpha:0.6)]
        let attributesRange:[String:AnyObject] = [
            NSFontAttributeName:UIFont.numeric(size:14),
            NSForegroundColorAttributeName:UIColor.white]
        let stringTitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VGridVisorBarRange_labelTitle", comment:""),
            attributes:attributesTitle)
        let stringSubtite:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VGridVisorBarRange_labelSubtitle", comment:""),
            attributes:attributesTitle)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringTitle)
        
        if let range:Double = MSession.sharedInstance.settings?.visorRange()
        {
            let rangeInt:Int = Int(range)
            let rawStringRange:String = "\(rangeInt)"
            let stringRange:NSAttributedString = NSAttributedString(
                string:rawStringRange,
                attributes:attributesRange)
            mutableString.append(stringRange)
        }
        
        mutableString.append(stringSubtite)
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        self.controller = controller
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.attributedText = mutableString
        
        addSubview(label)
        
        NSLayoutConstraint.equals(
            view:label,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
