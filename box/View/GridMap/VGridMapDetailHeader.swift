import UIKit

class VGridMapDetailHeader:UICollectionReusableView
{
    private weak var imageView:UIImageView!
    private let kImageTop:CGFloat = 10
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        self.imageView = imageView
        
        addSubview(imageView)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self,
            constant:kImageTop)
        NSLayoutConstraint.bottomToBottom(
            view:imageView,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(model:MGridMapDetail)
    {
        imageView.image = model.image
    }
}
