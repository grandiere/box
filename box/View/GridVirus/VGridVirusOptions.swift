import UIKit

class VGridVirusOptions:UIView
{
    private weak var controller:CGridVirus!
    
    init(controller:CGridVirus)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
