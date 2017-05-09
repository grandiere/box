import UIKit

class VGridVisorBarRange:UIView
{
    private weak var controller:CGridVisor!
    
    init(controller:CGridVisor)
    {
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
        
        addSubview(label)
        
        NSLayoutConstraint.equals(
            view:label,
            toView:self)
        
        guard
            
            let distance:MDistanceProtocol = MSession.sharedInstance.settings?.currentDistance()
        
        else
        {
            return
        }
        
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:13),
            NSForegroundColorAttributeName:UIColor(white:1, alpha:0.6)]
        let attributesRange:[String:AnyObject] = [
            NSFontAttributeName:UIFont.numeric(size:14),
            NSForegroundColorAttributeName:UIColor.white]
        let stringTitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VGridVisorBarRange_labelTitle", comment:""),
            attributes:attributesTitle)
        let stringSubtitle:NSAttributedString = NSAttributedString(
            string:distance.shortName,
            attributes:attributesRange)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringTitle)
        
        if let range:Double = MSession.sharedInstance.settings?.visorRange()
        {
            let convertedRange:Double = distance.convertFromStandard(standard:range)
            let rangeInt:Int = Int(convertedRange)
            let rawStringRange:String = "\(rangeInt)"
            let stringRange:NSAttributedString = NSAttributedString(
                string:rawStringRange,
                attributes:attributesRange)
            mutableString.append(stringRange)
        }
        
        mutableString.append(stringSubtitle)
        
        label.attributedText = mutableString
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
