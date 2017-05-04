import UIKit

class VGridVirusReleased:UIView
{
    private weak var controller:CGridVirus!
    private weak var layoutButtonLeft:NSLayoutConstraint!
    private(set) weak var label:UILabel!
    private let kImageTop:CGFloat = 100
    private let kImageHeight:CGFloat = 120
    private let kLabelMarginHorizontal:CGFloat = 10
    private let kLabelHeight:CGFloat = 160
    private let kButtonWidth:CGFloat = 120
    private let kButtonHeight:CGFloat = 34
    
    init(controller:CGridVirus)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.center
        imageView.image = #imageLiteral(resourceName: "assetGenericVirusReleased")
        imageView.clipsToBounds = true
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        self.label = label
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor.gridBlue
        button.setTitle(
            NSLocalizedString("VGridVirusReleased_button", comment:""),
            for:UIControlState.normal)
        button.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        button.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        button.titleLabel!.font = UIFont.bold(size:14)
        button.layer.cornerRadius = kButtonHeight / 2.0
        button.addTarget(
            self,
            action:#selector(actionButton(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(imageView)
        addSubview(label)
        addSubview(button)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self,
            constant:kImageTop)
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
        let width:CGFloat = bounds.width
        let remainWidth:CGFloat = width - kButtonWidth
        let marginLeft:CGFloat = remainWidth / 2.0
        layoutButtonLeft.constant = marginLeft
        
        super.layoutSubviews()
    }
    
    //MARK: action
    
    func actionButton(sender button:UIButton)
    {
        controller.back()
    }
}
