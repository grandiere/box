import UIKit

class VGridVisorBarRange:UIView
{
    private weak var controller:CGridVisor!
    private let kLabelLeft:CGFloat = 29
    
    init(controller:CGridVisor)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        self.controller = controller
        
        let background:UIImageView = UIImageView()
        background.isUserInteractionEnabled = false
        background.translatesAutoresizingMaskIntoConstraints = false
        background.clipsToBounds = true
        background.contentMode = UIViewContentMode.center
        background.image = #imageLiteral(resourceName: "assetGenericVisorRange")
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        
        addSubview(background)
        addSubview(label)
        
        NSLayoutConstraint.equals(
            view:background,
            toView:self)
        
        NSLayoutConstraint.equalsVertical(
            view:label,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:label,
            toView:self,
            constant:kLabelLeft)
        NSLayoutConstraint.rightToRight(
            view:label,
            toView:self)
        
        guard
            
            let distance:MDistanceProtocol = MSession.sharedInstance.settings?.currentDistance()
        
        else
        {
            return
        }
        
        let attributesRange:[String:AnyObject] = [
            NSFontAttributeName:UIFont.numeric(size:12),
            NSForegroundColorAttributeName:UIColor.black]
        let attributesDistance:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:10),
            NSForegroundColorAttributeName:UIColor(white:0, alpha:0.7)]
        
        let stringDistance:NSAttributedString = NSAttributedString(
            string:distance.shortName,
            attributes:attributesDistance)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
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
        
        mutableString.append(stringDistance)
        label.attributedText = mutableString
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
