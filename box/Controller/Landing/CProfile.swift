import UIKit

class CProfile:CController
{
    let model:MProfile
    private weak var viewProfile:VProfile!
    
    override init()
    {
        model = MProfile()
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewProfile:VProfile = VProfile(controller:self)
        self.viewProfile = viewProfile
        view = viewProfile
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        viewProfile.viewBar.updateHandler()
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func editHandler()
    {
        let controllerHandler:CHandler = CHandler()
        parentController.push(
            controller:controllerHandler,
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
