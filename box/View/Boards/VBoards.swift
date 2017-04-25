import UIKit

class VBoards:VView
{
    private weak var controller:CBoards!
    private weak var spinner:VSpinner?
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CBoards
        
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
