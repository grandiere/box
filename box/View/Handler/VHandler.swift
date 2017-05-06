import UIKit

class VHandler:VView
{
    private weak var controller:CHandler!
    private weak var viewField:VHandlerField!
    private weak var labelWarning:UILabel!
    private weak var layoutFieldLeft:NSLayoutConstraint!
    private let kTitleTop:CGFloat = 10
    private let kTitleHeight:CGFloat = 70
    private let kTitleMarginHorizontal:CGFloat = 10
    private let kFieldHeight:CGFloat = 50
    private let kFieldWidth:CGFloat = 150
    private let kWarningHeight:CGFloat = 50
    
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
        
        let viewField:VHandlerField = VHandlerField(
            controller:self.controller)
        self.viewField = viewField
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.numberOfLines = 0
        labelTitle.attributedText = mutableString
        
        let labelWarning:UILabel = UILabel()
        labelWarning.isUserInteractionEnabled = false
        labelWarning.translatesAutoresizingMaskIntoConstraints = false
        labelWarning.backgroundColor = UIColor.clear
        labelWarning.textAlignment = NSTextAlignment.center
        labelWarning.font = UIFont.regular(size:16)
        labelWarning.textColor = UIColor(white:1, alpha:0.8)
        labelWarning.text = NSLocalizedString("VHandler_labelWarning", comment:"")
        self.labelWarning = labelWarning
        
        let buttonDone:UIButton = UIButton()
        
        addSubview(labelTitle)
        addSubview(labelWarning)
        addSubview(viewField)
        
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
        
        NSLayoutConstraint.topToBottom(
            view:viewField,
            toView:labelTitle)
        NSLayoutConstraint.height(
            view:viewField,
            constant:kFieldHeight)
        NSLayoutConstraint.width(
            view:viewField,
            constant:kFieldWidth)
        layoutFieldLeft = NSLayoutConstraint.leftToLeft(
            view:viewField,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
