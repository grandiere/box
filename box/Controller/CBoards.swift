import UIKit

class CBoards:CController
{
    let model:MBoards
    private(set) weak var viewBoards:VBoards!
    private var firstTime:Bool
    
    override init()
    {
        firstTime = true
        model = MBoards()
        
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
            
            if let handler:String = MSession.sharedInstance.handler
            {
                if handler.characters.count < 1
                {
                    editHandler()
                }
            }
            else
            {
                editHandler()
            }
        }
        
        model.load(controller:self)
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
    
    func boardsLoaded()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewBoards.startLoading()
        }
    }
}
