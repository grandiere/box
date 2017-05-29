import UIKit

class VGridVisorMatchBaseBackground:UIView
{
    private weak var controller:CGridVisorMatch!
    private let kCornerRadius:CGFloat = 15
    private let kBorderWidth:CGFloat = 1
    private let kAlgoHeight:CGFloat = 60
    
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
        
        let viewAlgo:VGridVisorMatchBaseBackgroundAlgo = VGridVisorMatchBaseBackgroundAlgo(
            controller:controller)
        
        addSubview(blur)
        addSubview(viewAlgo)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewAlgo,
            toView:self)
        NSLayoutConstraint.height(
            view:viewAlgo,
            constant:kAlgoHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewAlgo,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
