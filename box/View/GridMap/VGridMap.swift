import UIKit

class VGridMap:VView
{
    private weak var controller:CGridMap!
    private(set) weak var viewRender:VGridMapRender!
    private let kBarHeight:CGFloat = 50
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CGridMap
        
        let viewRender:VGridMapRender = VGridMapRender(
            controller:self.controller)
        self.viewRender = viewRender
        
        let viewBar:VGridMapBar = VGridMapBar(
            controller:self.controller)
        
        addSubview(viewRender)
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
        
        NSLayoutConstraint.equals(
            view:viewRender,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
