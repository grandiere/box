import UIKit

class VLanding:VView
{
    private weak var controller:CLanding!
    private let kButtonTop:CGFloat = 100
    private let kButtonHeight:CGFloat = 50
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CLanding
        
        let buttonScanner:UIButton = UIButton()
        buttonScanner.translatesAutoresizingMaskIntoConstraints = false
        buttonScanner.setTitle(
            NSLocalizedString("VLanding_buttonScanner", comment:""),
            for:UIControlState.normal)
        buttonScanner.addTarget(
            self,
            action:#selector(actionScanner(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(buttonScanner)
        
        NSLayoutConstraint.topToTop(
            view:buttonScanner,
            toView:self,
            constant:kButtonTop)
        NSLayoutConstraint.height(
            view:buttonScanner,
            constant:kButtonHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:buttonScanner,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionScanner(sender button:UIButton)
    {
        controller.openScanner()
    }
}
