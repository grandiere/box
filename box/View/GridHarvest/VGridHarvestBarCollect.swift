import UIKit

class VGridHarvestBarCollect:UIButton
{
    private weak var controller:CGridHarvest!
    
    init(controller:CGridHarvest)
    {
        super.init(frame:frame)
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
