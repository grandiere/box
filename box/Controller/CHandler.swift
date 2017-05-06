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
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
