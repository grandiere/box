import UIKit

class VProfileBar:UIView
{
    private weak var controller:CProfile!
    private(set) weak var buttonHandler:UIButton!
    private let kButtonSize:CGFloat = 60
    private let kHandlerHeight:CGFloat = 40
    
    init(controller:CProfile)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.center
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "assetGenericProfile")
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.contentMode = UIViewContentMode.center
        backButton.imageView!.tintColor = UIColor.white
        backButton.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonHandler:UIButton = UIButton()
        buttonHandler.backgroundColor = UIColor.clear
        buttonHandler.translatesAutoresizingMaskIntoConstraints = false
        buttonHandler.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonHandler.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        buttonHandler.titleLabel!.font = UIFont.bold(size:16)
        buttonHandler.addTarget(
            self,
            action:#selector(actionHandler(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonHandler = buttonHandler
        
        addSubview(imageView)
        addSubview(backButton)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:backButton,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:backButton,
            toView:self)
        NSLayoutConstraint.size(
            view:backButton,
            constant:kButtonSize)
        
        NSLayoutConstraint.bottomToBottom(
            view:buttonHandler,
            toView:self)
        NSLayoutConstraint.height(
            view:buttonHandler,
            constant:kHandlerHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:buttonHandler,
            toView:self)
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
    
    func actionHandler(sender button:UIButton)
    {
        controller.editHandler()
    }
    
    //MARK: public
    
    func updateHandler()
    {
        guard
        
            let handler:String = MSession.sharedInstance.handler
        
        else
        {
            return
        }
        
        buttonHandler.setTitle(
            handler,
            for:UIControlState.normal)
    }
}
