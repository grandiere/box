import UIKit

class VGridCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var label:UILabel!
    private let attributesTitle:[String:AnyObject]
    private let attributesSubtitle:[String:AnyObject]
    private let kImageWidth:CGFloat = 130
    private let kLabelRight:CGFloat = 15
    private let kAlphaNotSelected:CGFloat = 1
    private let kAlphaSelected:CGFloat = 0.2
    
    override init(frame:CGRect)
    {
        attributesTitle = [
            NSFontAttributeName:UIFont.bolder(size:24),
            NSForegroundColorAttributeName:UIColor.white]
        attributesSubtitle = [
            NSFontAttributeName:UIFont.bold(size:17),
            NSForegroundColorAttributeName:UIColor(white:1, alpha:0.7)]
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
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
            toView:imageView)
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
            alpha = kAlphaSelected
        }
        else
        {
            alpha = kAlphaNotSelected
        }
    }
    
    //MARK: public
    
    func config(model:MGridItem)
    {
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        let stringTitle:NSAttributedString = NSAttributedString(
            string:model.title,
            attributes:attributesTitle)
        let stringSubtitle:NSAttributedString = NSAttributedString(
            string:model.subtitle,
            attributes:attributesSubtitle)
        mutableString.append(stringTitle)
        mutableString.append(stringSubtitle)
        
        imageView.image = model.image
        label.attributedText = mutableString
        
        hover()
    }
}
