import UIKit

class VGridHarvestBar:UIView
{
    private weak var controller:CGridHarvest!
    private weak var viewCollect:VGridHarvestBarCollect!
    private let kCollectWidth:CGFloat = 140
    
    init(controller:CGridHarvest)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let viewCollect:VGridHarvestBarCollect = VGridHarvestBarCollect(
            controller:controller)
        self.viewCollect = viewCollect
        
        addSubview(viewCollect)
        
        NSLayoutConstraint.equalsVertical(
            view:viewCollect,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:viewCollect,
            toView:self)
        NSLayoutConstraint.width(
            view:viewCollect,
            constant:kCollectWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
