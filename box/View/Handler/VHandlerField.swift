import UIKit

class VHandlerField:UITextField, UITextFieldDelegate
{
    private weak var controller:CHandler!
    
    init(controller:CHandler)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
