import UIKit

class VGridVisorMatchBaseAlgo:UIView
{
    private weak var controller:CGridVisorMatch!
    private let kImageMargin:CGFloat = 22
    
    init(controller:CGridVisorMatch)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        
        let background:UIImageView = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.clipsToBounds = true
        background.contentMode = UIViewContentMode.center
        background.isUserInteractionEnabled = false
        background.image = #imageLiteral(resourceName: "assetGenericMatchAlgo")
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = controller.model?.icon
        
        addSubview(background)
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:background,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self,
            margin:kImageMargin)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
