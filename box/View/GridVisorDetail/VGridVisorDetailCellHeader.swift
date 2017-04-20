import UIKit

class VGridVisorDetailCellHeader:VGridVisorDetailCell
{
    private weak var imageView:UIImageView!
    private weak var labelTitle:UILabel!
    private let kImageWidth:CGFloat = 100
    
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
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.bolder(size:22)
        labelTitle.textColor = UIColor.black
        self.labelTitle = labelTitle
        
        addSubview(imageView)
        addSubview(labelTitle)
        
        NSLayoutConstraint.equalsVertical(
            view:imageView,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        NSLayoutConstraint.width(
            view:imageView,
            constant:kImageWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:labelTitle,
            toView:imageView)
        NSLayoutConstraint.rightToRight(
            view:labelTitle,
            toView:self)
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
        labelTitle.text = modelHeader.title
    }
}
