import UIKit

class VGridVisorBar:UIView
{
    private weak var controller:CGridVisor!
    private let kBorderHeight:CGFloat = 1
    
    init(controller:CGridVisor)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let blur:VBlur = VBlur.dark()
        
        let border:VBorder = VBorder(color:UIColor(white:1, alpha:0.2))
        
        addSubview(blur)
        addSubview(border)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
