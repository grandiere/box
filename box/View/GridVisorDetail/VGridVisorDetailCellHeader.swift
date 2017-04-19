import UIKit

class VGridVisorDetailCellHeader:VGridVisorDetailCell
{
    private weak var imageView:UIImageView!
    private let kImageWidth:CGFloat = 160
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let imageView:UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.isUserInteractionEnabled = false
        self.imageView = imageView
        
        addSubview(imageView)
        
        NSLayoutConstraint.equalsVertical(
            view:imageView,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        NSLayoutConstraint.width(
            view:imageView,
            constant:kImageWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(model:MGridVisorDetailItem)
    {
        guard
        
            let modelHeader:MGridVisorDetailItemHeader = model as? MGridVisorDetailItemHeader
        
        else
        {
            return
        }
        
        imageView.image = modelHeader.image
    }
}
