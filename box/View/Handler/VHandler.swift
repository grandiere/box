import UIKit

class VHandler:VView
{
    private weak var controller:CHandler!
    private let kTitleTop:CGFloat = 10
    private let kTitleHeight:CGFloat = 60
    private let kTitleMarginHorizontal:CGFloat = 10
    
    override init(controller:CController)
    {
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:18),
            NSForegroundColorAttributeName:UIColor.white]
        let attributesSubtitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:16),
            NSForegroundColorAttributeName:UIColor(white:1, alpha:0.7)]

        let stringTitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VHandler_labelTitle", comment:""),
            attributes:attributesTitle)
        let stringSubtitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VHandler_labelSubtitle", comment:""),
            attributes:attributesSubtitle)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringTitle)
        mutableString.append(stringSubtitle)
        
        super.init(controller:controller)
        self.controller = controller as? CHandler
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.numberOfLines = 0
        labelTitle.attributedText = mutableString
        
        addSubview(labelTitle)
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self,
            constant:kTitleTop)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
        
        NSLayoutConstraint
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
