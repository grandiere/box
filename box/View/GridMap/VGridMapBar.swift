import UIKit

class VGridMapBar:UIView
{
    private weak var controller:CGridMap!
    private let kBorderHeight:CGFloat = 1
    private let kButtonWidth:CGFloat = 60
    
    init(controller:CGridMap)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let blur:VBlur = VBlur.light()
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBackBlack").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBackBlack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.contentMode = UIViewContentMode.center
        backButton.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        backButton.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonUser:UIButton = UIButton()
        buttonUser.translatesAutoresizingMaskIntoConstraints = false
        buttonUser.setImage(
            #imageLiteral(resourceName: "assetGenericMapUser").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonUser.setImage(
            #imageLiteral(resourceName: "assetGenericMapUser").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonUser.imageView!.contentMode = UIViewContentMode.center
        buttonUser.imageView!.clipsToBounds = true
        buttonUser.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        buttonUser.addTarget(
            self,
            action:#selector(actionUser(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(blur)
        addSubview(border)
        addSubview(backButton)
        addSubview(buttonUser)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
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
            constant:kButtonWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonUser,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:buttonUser,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonUser,
            constant:kButtonWidth)
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
    
    func actionUser(sender button:UIButton)
    {
        controller.viewMap.viewRender.centerOnUser()
    }
}
