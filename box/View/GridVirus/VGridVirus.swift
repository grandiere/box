import UIKit

class VGridVirus:VView
{
    private weak var controller:CGridVirus!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        
        self.controller = controller as? CGridVirus
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
