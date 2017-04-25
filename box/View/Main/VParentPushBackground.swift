import UIKit

class VParentPushBackground:UIView
{
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor(white:1, alpha:0.4)
        translatesAutoresizingMaskIntoConstraints = false
        alpha = 0
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
