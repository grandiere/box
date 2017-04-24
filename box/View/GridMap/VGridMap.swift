import UIKit

class VGridMap:VView
{
    private weak var controller:CGridMap!
    private let kBarHeight:CGFloat = 50
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CGridMap
        
        let viewBar:VGridMapBar = VGridMapBar(
            controller:self.controller)
        
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
