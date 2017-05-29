import UIKit

class VGridVisorMatchBaseBackground:UIView
{
    private weak var controller:CGridVisorMatch!
    private let kCornerRadius:CGFloat = 15
    private let kBorderWidth:CGFloat = 1
    
    init(controller:CGridVisorMatch)
    {
        super.init(frame:CGRect.zero)
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.borderWidth = kBorderWidth
        layer.borderColor = UIColor(white:1, alpha:0.3).cgColor
        layer.cornerRadius = kCornerRadius
        
        let blur:VBlur = VBlur.light()
        
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
