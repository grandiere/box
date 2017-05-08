import UIKit

class VGridVisorBar:UIView
{
    private(set) weak var viewEnergy:VGridVisorBarEnergy!
    private(set) weak var viewRange:VGridVisorBarRange!
    private weak var controller:CGridVisor!
    private let kBorderHeight:CGFloat = 1
    private let kButtonWidth:CGFloat = 60
    private let kEnergyWidth:CGFloat = 260
    
    init(controller:CGridVisor)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let blur:VBlur = VBlur.dark()
        
        let border:VBorder = VBorder(color:UIColor(white:1, alpha:0.1))
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBackWhite").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBackWhite").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.contentMode = UIViewContentMode.center
        backButton.imageView!.tintColor = UIColor(white:1, alpha:0.2)
        backButton.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let viewEnergy:VGridVisorBarEnergy = VGridVisorBarEnergy(
            controller:controller)
        self.viewEnergy = viewEnergy
        
        addSubview(blur)
        addSubview(border)
        addSubview(backButton)
        addSubview(viewEnergy)
        
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
            view:viewEnergy,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:viewEnergy,
            toView:self)
        NSLayoutConstraint.width(
            view:viewEnergy,
            constant:kEnergyWidth)
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
