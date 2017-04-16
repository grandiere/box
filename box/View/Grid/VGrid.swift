import UIKit

class VGrid:VView
{
    private weak var controller:CGrid!
    private weak var spinner:VSpinner!
    private let kBarHeight:CGFloat = 60
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CGrid
     
        let viewBar:VGridBar = VGridBar(
            controller:self.controller)
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        addSubview(viewBar)
        addSubview(spinner)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
