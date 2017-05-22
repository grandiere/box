import UIKit

class VGridHarvestBarCollect:UIButton
{
    private weak var controller:CGridHarvest!
    private let KBorderWidth:CGFloat = 1
    private let kCornerRadius:CGFloat = 6
    
    init(controller:CGridHarvest)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = kCornerRadius
        layer.borderWidth = KBorderWidth
        layer.borderColor = UIColor.gridBlue.cgColor
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
