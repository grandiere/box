import UIKit

class VTutorialBar:UIView
{
    private weak var controller:CTutorial!
    private let kBorderHeight:CGFloat = 1
    private let kBackWidth:CGFloat = 60
    private let kIconHeight:CGFloat = 50
    private let kWriteBottom:CGFloat = -10
    private let kWriteHeight:CGFloat = 34
    private let kWriteRight:CGFloat = -10
    private let kWriteWidth:CGFloat = 120
    private let kWriteRadius:CGFloat = 5
    
    init(controller:CTutorial)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.black
        self.controller = controller
        
        let border:VBorder = VBorder(color:UIColor.white)
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        backButton.imageView!.tintColor = UIColor(white:1, alpha:0.2)
        backButton.imageView!.contentMode = UIViewContentMode.center
        backButton.imageView!.clipsToBounds = true
        backButton.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let icon:UIImageView = UIImageView()
        icon.isUserInteractionEnabled = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.clipsToBounds = true
        icon.contentMode = UIViewContentMode.center
        icon.image = #imageLiteral(resourceName: "assetGenericHelp")
        
        let writeButton:UIButton = UIButton()
        writeButton.translatesAutoresizingMaskIntoConstraints = false
        writeButton.clipsToBounds = true
        writeButton.backgroundColor = UIColor(white:1, alpha:0.3)
        writeButton.setTitle(
            NSLocalizedString("VTutorialBar_writeButton", comment:""),
            for:UIControlState.normal)
        writeButton.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        writeButton.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        writeButton.titleLabel!.font = UIFont.bold(size:14)
        writeButton.layer.cornerRadius = kWriteRadius
        writeButton.addTarget(
            self,
            action:#selector(actionWrite(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(icon)
        addSubview(border)
        addSubview(backButton)
        addSubview(writeButton)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        NSLayoutConstraint.equalsVertical(
            view:backButton,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:backButton,
            toView:self)
        NSLayoutConstraint.width(
            view:backButton,
            constant:kBackWidth)
        
        NSLayoutConstraint.topToTop(
            view:icon,
            toView:self)
        NSLayoutConstraint.height(
            view:icon,
            constant:kIconHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:icon,
            toView:self)
        
        NSLayoutConstraint.height(
            view:writeButton,
            constant:kWriteHeight)
        NSLayoutConstraint.bottomToBottom(
            view:writeButton,
            toView:self,
            constant:kWriteBottom)
        NSLayoutConstraint.width(
            view:writeButton,
            constant:kWriteWidth)
        NSLayoutConstraint.rightToRight(
            view:writeButton,
            toView:self,
            constant:kWriteRight)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
    
    func actionWrite(sender button:UIButton)
    {
        controller.write()
    }
}
