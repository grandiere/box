import UIKit

class VGridMap:VView
{
    private(set) weak var viewRender:VGridMapRender!
    private weak var viewDetail:VGridMapDetail!
    private weak var controller:CGridMap!
    private weak var layoutDetailBottom:NSLayoutConstraint!
    private let kBarHeight:CGFloat = 50
    private let kDetailHeight:CGFloat = 240
    private let kDetailMinBottom:CGFloat = 25
    private let kAnimationDuration:TimeInterval = 0.3
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CGridMap
        
        let viewRender:VGridMapRender = VGridMapRender(
            controller:self.controller)
        self.viewRender = viewRender
        
        let viewBar:VGridMapBar = VGridMapBar(
            controller:self.controller)
        
        let viewDetail:VGridMapDetail = VGridMapDetail(
            controller:self.controller)
        self.viewDetail = viewDetail
        
        addSubview(viewRender)
        addSubview(viewBar)
        addSubview(viewDetail)
        
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
        
        layoutDetailBottom = NSLayoutConstraint.bottomToBottom(
            view:viewDetail,
            toView:self,
            constant:kDetailHeight)
        NSLayoutConstraint.height(
            view:viewDetail,
            constant:kDetailHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewDetail,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func showDetail(annotation:MGridMapAnnotation)
    {
        layoutDetailBottom.constant = kDetailMinBottom
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
        
        viewDetail.updateAnnotation(annotation:annotation)
    }
    
    func hideDetail()
    {
        layoutDetailBottom.constant = kDetailHeight
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
}
