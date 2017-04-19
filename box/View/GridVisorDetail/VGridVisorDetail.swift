import UIKit

class VGridVisorDetail:VView
{
    private weak var controller:CGridVisorDetail!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CGridVisorDetail
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
