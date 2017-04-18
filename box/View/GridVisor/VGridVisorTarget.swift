import UIKit

class VGridVisorTarget:UIView
{
    private weak var controller:CGridVisor!
    private weak var viewFinder:VGridVisorTargetFinder!
    
    init(controller:CGridVisor)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let button:UIButton = UIButton()
        button.backgroundColor = UIColor.clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.addTarget(
            self,
            action:#selector(actionButton(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let viewFinder:VGridVisorTargetFinder = VGridVisorTargetFinder(
            controller:controller)
        self.viewFinder = viewFinder
        
        addSubview(viewFinder)
        addSubview(button)
        
        NSLayoutConstraint.equals(
            view:button,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:viewFinder,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionButton(sender button:UIButton)
    {
        
    }
    
    //MARK: public
    
    func update()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewFinder.setNeedsDisplay()
        }
    }
}
