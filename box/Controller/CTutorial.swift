import UIKit

class CTutorial:CController
{
    let model:MTutorial
    private weak var viewTutorial:VTutorial!
    
    override init()
    {
        model = MTutorial()
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewTutorial:VTutorial = VTutorial(controller:self)
        self.viewTutorial = viewTutorial
        view = viewTutorial
    }
    
    //MARK: public
    
    func tutorialSelected(model:MHelp)
    {
        let controllerHelp:CHelp = CHelp(model:model)
        parentController.push(
            controller:controllerHelp,
            vertical:CParent.TransitionVertical.fromTop,
            background:false)
    }
}
