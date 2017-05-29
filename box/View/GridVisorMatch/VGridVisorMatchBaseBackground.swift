import UIKit

class VGridVisorMatchBaseBackground:UIView
{
    private weak var controller:CGridVisorMatch!
    private weak var imageView:UIImageView!
    private let kCornerRadius:CGFloat = 15
    private let kBorderWidth:CGFloat = 1
    private let kImageHeight:CGFloat = 45
    private let kImageTop:CGFloat = 10
    
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
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = controller.model?.icon
        self.imageView = imageView
        
        addSubview(blur)
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self,
            constant:kImageTop)
        NSLayoutConstraint.height(
            view:imageView,
            constant:kImageHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
