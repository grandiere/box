import UIKit

class VHelpCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var label:UILabel!
    private weak var layoutLabelHeight:NSLayoutConstraint!
    private let drawingOptions:NSStringDrawingOptions
    private let labelMargin2:CGFloat
    private let kLabelMargin:CGFloat = 10
    private let kLabelMaxHeight:CGFloat = 900
    private let kImageTop:CGFloat = 20
    private let kImageHeight:CGFloat = 180
    
    override init(frame:CGRect)
    {
        drawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesLineFragmentOrigin,
            NSStringDrawingOptions.usesFontLeading])
        labelMargin2 = kLabelMargin + kLabelMargin
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.center
        imageView.clipsToBounds = true
        self.imageView = imageView
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        self.label = label
        
        addSubview(label)
        addSubview(imageView)
        
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self,
            constant:kImageTop)
        NSLayoutConstraint.height(
            view:imageView,
            constant:kImageHeight)
        
        NSLayoutConstraint.topToBottom(
            view:label,
            toView:imageView)
        layoutLabelHeight = NSLayoutConstraint.height(
            view:label)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(model:MHelpProtocol)
    {
        imageView.image = model.image
        
        let attributedText:NSAttributedString = model.message
        label.attributedText = model.message
        
        let width:CGFloat = bounds.maxX
        let usableWidth:CGFloat = width - labelMargin2
        let usableSize:CGSize = CGSize(
            width:usableWidth,
            height:kLabelMaxHeight)
        let textRect:CGRect = attributedText.boundingRect(
            with:usableSize,
            options:drawingOptions,
            context:nil)
        let textHeight:CGFloat = ceil(textRect.size.height)
        layoutLabelHeight.constant = textHeight
    }
}
