import UIKit

class VGridHarvest:VView
{
    private weak var controller:CGridHarvest!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CGridHarvest
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
