import UIKit

class VBorder:UIView
{
    init(color:UIColor)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = color
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
