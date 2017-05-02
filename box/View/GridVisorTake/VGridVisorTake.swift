import UIKit

class VGridVisorTake:VView
{
    private weak var controller:CGridVisorTake!
    private weak var label:UILabel!
    private weak var button:UIButton!
    private weak var layoutButtonLeft:NSLayoutConstraint!
    private let kImageHeight:CGFloat = 150
    private let kLabelHeight:CGFloat = 300
    private let kLabelMarginHorizontal:CGFloat = 10
    private let kButtonWidth:CGFloat = 90
    private let kButtonHeight:CGFloat = 34
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CGridVisorTake
        
        let blur:VBlur = VBlur.extraLight()
        
        let imageView:UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.isUserInteractionEnabled = false
        imageView.image = #imageLiteral(resourceName: "assetTextureAidDetail")
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        self.label = label
        
        let button:UIButton = UIButton()
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor.gridBlue
        button.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        button.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        button.setTitle(
            NSLocalizedString("VGridVisorTake_button", comment:""),
            for:UIControlState.normal)
        button.titleLabel!.font = UIFont.bold(size:14)
        button.layer.cornerRadius = kButtonHeight / 2.0
        button.addTarget(
            self,
            action:#selector(actionButton(sender:)),
            for:UIControlEvents.touchUpInside)
        self.button = button
        
        addSubview(blur)
        addSubview(imageView)
        addSubview(label)
        addSubview(button)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        NSLayoutConstraint.height(
            view:imageView,
            constant:kImageHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:label,
            toView:imageView)
        NSLayoutConstraint.height(
            view:label,
            constant:kLabelHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self,
            margin:kLabelMarginHorizontal)
        
        NSLayoutConstraint.topToBottom(
            view:button,
            toView:label)
        NSLayoutConstraint.height(
            view:button,
            constant:kButtonHeight)
        layoutButtonLeft = NSLayoutConstraint.leftToLeft(
            view:button,
            toView:self)
        NSLayoutConstraint.width(
            view:button,
            constant:kButtonWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remain:CGFloat = width - kButtonWidth
        let marginLeft:CGFloat = remain / 2.0
        layoutButtonLeft.constant = marginLeft
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionButton(sender button:UIButton)
    {
        controller.done()
    }
    
    //MARK: public
    
    func aidDefined(model:MGridVisorTakeProtocol)
    {
        label.attributedText = model.descr
        button.isHidden = false
    }
}
