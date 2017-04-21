import UIKit

class VLandingBar:UIView
{
    private weak var controller:CLanding!
    private let kBorderHeight:CGFloat = 1
    private let kBlurAlpha:CGFloat = 0.97
    
    init(controller:CLanding)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let blurContainer:UIView = UIView()
        blurContainer.isUserInteractionEnabled = false
        blurContainer.translatesAutoresizingMaskIntoConstraints = false
        blurContainer.clipsToBounds = true
        blurContainer.alpha = kBlurAlpha
        
        let blur:VBlur = VBlur.dark()
        
        let border:VBorder = VBorder(color:UIColor(white:1, alpha:0.1))
        
        blurContainer.addSubview(blur)
        addSubview(blurContainer)
        addSubview(border)
        
        NSLayoutConstraint.equals(
            view:blurContainer,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:blurContainer)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
