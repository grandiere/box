import UIKit

class VHandlerField:UITextField, UITextFieldDelegate
{
    private weak var controller:CHandler!
    private let kBorderHeight:CGFloat = 1
    
    init(controller:CHandler)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        
        self.controller = controller
        
        let border:VBorder = VBorder(color:UIColor(white:1, alpha:0.6))
        
        addSubview(border)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:1)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
