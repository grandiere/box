import UIKit

class VGridCell:UICollectionViewCell
{
    private weak var model:MGridItem?
    private weak var imageView:UIImageView!
    private weak var label:UILabel!
    private let attributesTitle:[String:AnyObject]
    private let attributesSubtitle:[String:AnyObject]
    private let kImageWidth:CGFloat = 100
    private let kLabelLeft:CGFloat = -9
    private let kLabelRight:CGFloat = 10
    
    override init(frame:CGRect)
    {
        attributesTitle = [
            NSFontAttributeName:UIFont.bold(size:18)]
        attributesSubtitle = [
            NSFontAttributeName:UIFont.regular(size:13)]
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.tintColor = UIColor.white
        self.imageView = imageView
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.isUserInteractionEnabled = false
        label.numberOfLines = 0
        self.label = label
        
        addSubview(imageView)
        addSubview(label)
        
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
            view:label,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:label,
            toView:imageView,
            constant:kLabelLeft)
        NSLayoutConstraint.rightToRight(
            view:label,
            toView:self,
            constant:kLabelRight)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            imageView.image = model?.image.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            label.textColor = UIColor.white
        }
        else
        {
            imageView.image = model?.image.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            label.textColor = UIColor.gridOrange
        }
    }
    
    //MARK: public
    
    func config(model:MGridItem)
    {
        self.model = model
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        let stringTitle:NSAttributedString = NSAttributedString(
            string:model.title,
            attributes:attributesTitle)
        let stringSubtitle:NSAttributedString = NSAttributedString(
            string:model.subtitle,
            attributes:attributesSubtitle)
        mutableString.append(stringTitle)
        mutableString.append(stringSubtitle)
        label.attributedText = mutableString
        
        hover()
    }
}
