import UIKit

class CHandler:CController
{
    private weak var viewHandler:VHandler!
    
    override func loadView()
    {
        let viewHandler:VHandler = VHandler(controller:self)
        self.viewHandler = viewHandler
        view = viewHandler
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        parentController.viewParent.panRecognizer.isEnabled = false
        viewHandler.viewField.becomeFirstResponder()
        updateWarning()
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func updateWarning()
    {
        let hidden:Bool
        
        if let handler:String = MSession.sharedInstance.handler
        {
            if handler.characters.count > 0
            {
                hidden = true
            }
            else
            {
                hidden = false
            }
        }
        else
        {
            hidden = false
        }
        
        viewHandler.labelWarning.isHidden = hidden
    }
}
