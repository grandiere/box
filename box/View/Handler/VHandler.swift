import UIKit

class VHandler:VView
{
    private weak var controller:CHandler!
    private(set) weak var viewField:VHandlerField!
    private(set) weak var labelWarning:UILabel!
    private weak var layoutFieldLeft:NSLayoutConstraint!
    private weak var layoutButtonLeft:NSLayoutConstraint!
    private let kTitleHeight:CGFloat = 120
    private let kTitleMarginHorizontal:CGFloat = 10
    private let kFieldHeight:CGFloat = 50
    private let kFieldWidth:CGFloat = 120
    private let kWarningHeight:CGFloat = 90
    private let kButtonWidth:CGFloat = 100
    private let kButtonHeight:CGFloat = 34
    
    override init(controller:CController)
    {
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:19),
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
        labelWarning.font = UIFont.regular(size:15)
        labelWarning.textColor = UIColor(white:1, alpha:0.6)
        labelWarning.text = NSLocalizedString("VHandler_labelWarning", comment:"")
        self.labelWarning = labelWarning
        
        let buttonDone:UIButton = UIButton()
        buttonDone.translatesAutoresizingMaskIntoConstraints = false
        buttonDone.clipsToBounds = true
        buttonDone.backgroundColor = UIColor.gridBlue
        buttonDone.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonDone.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        buttonDone.setTitle(
            NSLocalizedString("VHandler_buttonDone", comment:""),
            for:UIControlState.normal)
        buttonDone.titleLabel!.font = UIFont.bold(size:14)
        buttonDone.layer.cornerRadius = kButtonHeight / 2.0
        buttonDone.addTarget(
            self,
            action:#selector(actionDone(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(labelTitle)
        addSubview(labelWarning)
        addSubview(viewField)
        addSubview(buttonDone)
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self)
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
        
        NSLayoutConstraint.topToBottom(
            view:labelWarning,
            toView:viewField)
        NSLayoutConstraint.height(
            view:labelWarning,
            constant:kWarningHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelWarning,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:buttonDone,
            toView:labelWarning)
        NSLayoutConstraint.height(
            view:buttonDone,
            constant:kButtonHeight)
        NSLayoutConstraint.width(
            view:buttonDone,
            constant:kButtonWidth)
        layoutButtonLeft = NSLayoutConstraint.leftToLeft(
            view:buttonDone,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        
        let remainField:CGFloat = width - kFieldWidth
        let fieldLeft:CGFloat = remainField / 2.0
        layoutFieldLeft.constant = fieldLeft
        
        let remainButton:CGFloat = width - kButtonWidth
        let buttonLeft:CGFloat = remainButton / 2.0
        layoutButtonLeft.constant = buttonLeft
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionDone(sender button:UIButton)
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        controller.back()
    }
}
