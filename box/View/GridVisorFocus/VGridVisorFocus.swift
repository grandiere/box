import UIKit

class VGridVisorFocus:VView
{
    private weak var controller:CGridVisorFocus!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CGridVisorFocus
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
