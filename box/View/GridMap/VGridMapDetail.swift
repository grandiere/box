import UIKit

class VGridMapDetail:UIView
{
    private weak var controller:CGridMap!
    private let kCornerRadius:CGFloat = 10
    private let kBorderWidth:CGFloat = 1
    
    init(controller:CGridMap)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = kCornerRadius
        layer.borderWidth = kBorderWidth
        layer.borderColor = UIColor.black.cgColor
        
        let blur:VBlur = VBlur.extraLight()
        
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
