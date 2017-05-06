import UIKit

class VHandler:VView
{
    private weak var controller:CHandler!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CHandler
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
