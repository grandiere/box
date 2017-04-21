import UIKit

class VStats:VView
{
    private weak var controller:CStats!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CStats
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
