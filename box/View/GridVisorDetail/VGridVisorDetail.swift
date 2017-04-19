import UIKit

class VGridVisorDetail:VView
{
    private weak var controller:CGridVisorDetail!
    private let kBarHeight:CGFloat = 50
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CGridVisorDetail
        
        let blur:VBlur = VBlur.extraLight()
        
        let viewBar:VGridVisorDetailBar = VGridVisorDetailBar(
            controller:self.controller)
        
        addSubview(blur)
        addSubview(viewBar)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
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
