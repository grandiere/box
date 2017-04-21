import UIKit

class VLanding:VView
{
    private weak var controller:CLanding!
    private weak var spinner:VSpinner?
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CLanding
        
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
    
    deinit
    {
        spinner?.stopAnimating()
    }
    
    //MARK: actions
    
    func actionScanner(sender button:UIButton)
    {
        controller.openScanner()
    }
    
    //MARK: public
    
    func sessionLoaded()
    {
        spinner?.stopAnimating()
        spinner?.removeFromSuperview()
    }
}
