import UIKit

class VGridVisorDetailBar:UIView
{
    private weak var controller:CGridVisorDetail!
    
    init(controller:CGridVisorDetail)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
