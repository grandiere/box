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
        
        let viewBar:v
        
        addSubview(blur)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
