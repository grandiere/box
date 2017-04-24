import UIKit

class VGridMap:VView
{
    private weak var controller:CGridMap!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CGridMap
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
