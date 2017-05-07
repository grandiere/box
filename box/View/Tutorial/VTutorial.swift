import UIKit

class VTutorial:VView
{
    private weak var controller:CTutorial!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CTutorial
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
