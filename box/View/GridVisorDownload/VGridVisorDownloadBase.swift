import UIKit

class VGridVisorDownloadBase:UIView
{
    private weak var imageView:UIImageView!
    private weak var background:UIView!
    private weak var label:UILabel!
    private let kAnimationDuration:TimeInterval = 1
    private let kMargin:CGFloat = 10
    private let kCornerRadius:CGFloat = 70
    private let kDownloadedRadius:CGFloat = 8
    
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
        background.backgroundColor = UIColor(white:1, alpha:0.9)
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
        
        let label:UILabel = UILabel()
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.isUserInteractionEnabled = false
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        self.label = label
        
        addSubview(background)
        addSubview(imageView)
        addSubview(label)
        
        NSLayoutConstraint.equals(
            view:background,
            toView:self,
            margin:kMargin)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:label,
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
    
    //MARK: public
    
    func downloadedReady(model:MGridVisorDownloadProtocol)
    {
        label.attributedText = model.descr
        imageView.stopAnimating()
        imageView.isHidden = true
        layer.cornerRadius = kDownloadedRadius
        background.layer.cornerRadius = kDownloadedRadius
    }
    
    func downloadedAnimation()
    {
        background.backgroundColor = UIColor(white:1, alpha:0.98)
        label.alpha = 1
    }
}
