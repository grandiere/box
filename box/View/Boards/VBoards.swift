import UIKit

class VBoards:VView
{
    private weak var controller:CBoards!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CBoards
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
