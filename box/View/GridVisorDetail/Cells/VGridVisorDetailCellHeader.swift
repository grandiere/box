import UIKit

class VGridVisorDetailCellHeader:VGridVisorDetailCell
{
    private weak var imageView:UIImageView!
    private weak var labelTitle:UILabel!
    private let kImageHeight:CGFloat = 220
    private let kTitleHeight:CGFloat = 60
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let finder:UIImageView = UIImageView()
        finder.isUserInteractionEnabled = false
        finder.translatesAutoresizingMaskIntoConstraints = false
        finder.contentMode = UIViewContentMode.center
        finder.clipsToBounds = true
        finder.image = #imageLiteral(resourceName: "assetGenericFinder")
        
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
        labelTitle.font = UIFont.bold(size:15)
        labelTitle.textColor = UIColor.black
        labelTitle.textAlignment = NSTextAlignment.center
        self.labelTitle = labelTitle
        
        addSubview(finder)
        addSubview(imageView)
        addSubview(labelTitle)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        NSLayoutConstraint.height(
            view:imageView,
            constant:kImageHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:finder,
            toView:imageView)
        
        NSLayoutConstraint.bottomToBottom(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(controller:CGridVisorDetail, model:MGridVisorDetailProtocol)
    {
        super.config(controller:controller, model:model)
        
        guard
        
            let modelHeader:MGridVisorDetailHeader = model as? MGridVisorDetailHeader
        
        else
        {
            return
        }
        
        imageView.image = modelHeader.icon
        labelTitle.text = modelHeader.title
    }
}
