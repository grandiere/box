import UIKit

class VGridVisorMatchBase:UIView
{
    private weak var controller:CGridVisorMatch!
    private let kCornerRadius:CGFloat = 6
    private let kBorderWidth:CGFloat = 1
    
    init(controller:CGridVisorMatch)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = kCornerRadius
        layer.borderWidth = kBorderWidth
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
