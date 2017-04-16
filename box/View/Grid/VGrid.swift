import UIKit

class VGrid:VView
{
    private weak var controller:CGrid!
    private weak var spinner:VSpinner!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CGrid
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        addSubview(spinner)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
