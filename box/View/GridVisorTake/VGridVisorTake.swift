import UIKit

class VGridVisorTake:VView
{
    private weak var controller:CGridVisorTake!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CGridVisorTake
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
