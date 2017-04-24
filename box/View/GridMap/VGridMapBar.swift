import UIKit

class VGridMapBar:UIView
{
    private weak var controller:CGridMap!
    
    init(controller:CGridMap)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
