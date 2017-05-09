import UIKit

class VStoreBar:UIView
{
    private weak var controller:CStore!
    private let kBorderHeight:CGFloat = 1
    private let kContentTop:CGFloat = 20
    private let kBackWidth:CGFloat = 60
    
    init(controller:CStore)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        
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
        buttonBack.imageView!.tintColor = UIColor(white:0, alpha:0.1)
        buttonBack.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(border)
        addSubview(icon)
        addSubview(buttonBack)
        
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
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.bottomToBottom(
            view:icon,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:icon,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:buttonBack,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.bottomToBottom(
            view:buttonBack,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:buttonBack,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonBack,
            constant:kBackWidth)
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
}
