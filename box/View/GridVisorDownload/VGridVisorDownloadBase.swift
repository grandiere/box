import UIKit

class VGridVisorDownloadBase:UIView
{
    private weak var imageView:UIImageView!
    private weak var background:UIView!
    private let kAnimationDuration:TimeInterval = 1
    private let kMargin:CGFloat = 10
    private let kCornerRadius:CGFloat = 70
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor(white:1, alpha:0.2)
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        
        let images:[UIImage] = [
            #imageLiteral(resourceName: "assetDownload0"),
            #imageLiteral(resourceName: "assetDownload1"),
            #imageLiteral(resourceName: "assetDownload2"),
            #imageLiteral(resourceName: "assetDownload3"),
            #imageLiteral(resourceName: "assetDownload4")]

        let background:UIView = UIView()
        background.isUserInteractionEnabled = false
        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = UIColor(white:1, alpha:0.95)
        background.clipsToBounds = true
        background.layer.cornerRadius = kCornerRadius
        self.background = background
        
        let imageView:UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.isUserInteractionEnabled = false
        imageView.animationImages = images
        imageView.animationDuration = kAnimationDuration
        imageView.startAnimating()
        self.imageView = imageView
        
        addSubview(background)
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:background,
            toView:self,
            margin:kMargin)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        imageView.stopAnimating()
    }
}
