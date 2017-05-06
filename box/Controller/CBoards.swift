import UIKit

class CBoards:CController
{
    private weak var viewBoards:VBoards!
    private var firstTime:Bool
    
    override init()
    {
        firstTime = true
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewBoards:VBoards = VBoards(controller:self)
        self.viewBoards = viewBoards
        view = viewBoards
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        if firstTime
        {
            firstTime = false
            
            if MSession.sharedInstance.handler == nil
            {
                editHandler()
            }
        }
    }
    
    //MARK: private
    
    private func editHandler()
    {
        let controllerHandler:CHandler = CHandler()
        parentController.push(
            controller:controllerHandler,
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
