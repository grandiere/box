import UIKit

class VProfile:VView
{
    private weak var controller:CProfile!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CProfile
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
