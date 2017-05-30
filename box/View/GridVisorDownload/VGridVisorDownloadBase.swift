import UIKit

class VGridVisorDownloadBase:UIView
{
    private weak var imageView:UIImageView!
    private let kAnimationDuration:TimeInterval = 1
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        
        let images:[UIImage] = [
            #imageLiteral(resourceName: "assetDownload0"),
            #imageLiteral(resourceName: "assetDownload1"),
            #imageLiteral(resourceName: "assetDownload2"),
            #imageLiteral(resourceName: "assetDownload3"),
            #imageLiteral(resourceName: "assetDownload4")]
        
        let blur:VBlur = VBlur.light()
        
        let imageView:UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.isUserInteractionEnabled = false
        imageView.animationImages = images
        imageView.animationDuration = kAnimationDuration
        imageView.startAnimating()
        self.imageView = imageView
        
        addSubview(blur)
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
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
