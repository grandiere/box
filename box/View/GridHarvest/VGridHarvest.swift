import UIKit

class VGridHarvest:VView
{
    private weak var controller:CGridHarvest!
    private weak var viewBar:VGridHarvestBar!
    private let kBarHeight:CGFloat = 150
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CGridHarvest
        
        let viewBar:VGridHarvestBar = VGridHarvestBar(controller:self.controller)
        self.viewBar = viewBar
        
        addSubview(viewBar)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
