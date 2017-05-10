import UIKit

class CHelp:CController
{
    let model:MHelp
    private weak var viewHelp:VHelp!
    
    init(model:MHelp)
    {
        self.model = model
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewHelp:VHelp = VHelp(controller:self)
        self.viewHelp = viewHelp
        view = viewHelp
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(
            vertical:CParent.TransitionVertical.fromTop)
    }
}
