import UIKit

class VStoreBar:UIView
{
    private weak var controller:CStore!
    private let kBorderHeight:CGFloat = 1
    private let kIconHeight:CGFloat = 50
    private let kBackWidth:CGFloat = 60
    private let kRestoreRight:CGFloat = -10
    private let kRestoreWidth:CGFloat = 174
    private let kRestoreBottom:CGFloat = -10
    private let kRestoreHeight:CGFloat = 33
    private let kCornerRadius:CGFloat = 6
    
    init(controller:CStore)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let border:VBorder = VBorder(color:UIColor.white)
        
        let icon:UIImageView = UIImageView()
        icon.isUserInteractionEnabled = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = #imageLiteral(resourceName: "assetGenericStore")
        icon.clipsToBounds = true
        icon.contentMode = UIViewContentMode.center
        
        let buttonBack:UIButton = UIButton()
        buttonBack.translatesAutoresizingMaskIntoConstraints = false
        buttonBack.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonBack.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonBack.imageView!.clipsToBounds = true
        buttonBack.imageView!.contentMode = UIViewContentMode.center
        buttonBack.imageView!.tintColor = UIColor(white:1, alpha:0.1)
        buttonBack.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonRestore:UIButton = UIButton()
        buttonRestore.backgroundColor = UIColor(white:1, alpha:0.2)
        buttonRestore.clipsToBounds = true
        buttonRestore.translatesAutoresizingMaskIntoConstraints = false
        buttonRestore.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonRestore.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        buttonRestore.setTitle(
            NSLocalizedString("VStoreBar_buttonRestore", comment:""),
            for:UIControlState.normal)
        buttonRestore.titleLabel!.font = UIFont.regular(size:14)
        buttonRestore.layer.cornerRadius = kCornerRadius
        buttonRestore.addTarget(
            self,
            action:#selector(actionRestore(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(border)
        addSubview(icon)
        addSubview(buttonBack)
        addSubview(buttonRestore)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:icon,
            toView:self)
        NSLayoutConstraint.height(
            view:icon,
            constant:kIconHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:icon,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:buttonBack,
            toView:self)
        NSLayoutConstraint.height(
            view:buttonBack,
            constant:kIconHeight)
        NSLayoutConstraint.leftToLeft(
            view:buttonBack,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonBack,
            constant:kBackWidth)
        
        NSLayoutConstraint.bottomToBottom(
            view:buttonRestore,
            toView:self,
            constant:kRestoreBottom)
        NSLayoutConstraint.height(
            view:buttonRestore,
            constant:kRestoreHeight)
        NSLayoutConstraint.rightToRight(
            view:buttonRestore,
            toView:self,
            constant:kRestoreRight)
        NSLayoutConstraint.width(
            view:buttonRestore,
            constant:kRestoreWidth)
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
    
    func actionRestore(sender button:UIButton)
    {
        controller.restorePurchases()
    }
}
