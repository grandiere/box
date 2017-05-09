import UIKit

class VStoreHeader:UICollectionReusableView
{
    private let attrTitle:[String:Any]
    private let attrDescr:[String:Any]
    private let labelMargins:CGFloat
    private weak var label:UILabel!
    private weak var imageView:UIImageView!
    private weak var layoutLabelHeight:NSLayoutConstraint!
    private let kLabelTop:CGFloat = 16
    private let kLabelLeft:CGFloat = 10
    private let kLabelRight:CGFloat = -10
    private let kImageSize:CGFloat = 100
    
    override init(frame:CGRect)
    {
        attrTitle = [
            NSFontAttributeName:UIFont.bolder(size:20),
            NSForegroundColorAttributeName:UIColor.hyperBlue]
        
        attrDescr = [
            NSFontAttributeName:UIFont.regular(size:16),
            NSForegroundColorAttributeName:UIColor.black]
        
        labelMargins = -kLabelRight + kLabelLeft + kImageSize
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        isUserInteractionEnabled = false
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        self.label = label
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = imageView
        
        addSubview(label)
        addSubview(imageView)
        
        NSLayoutConstraint.topToTop(
            view:label,
            toView:self,
            constant:kLabelTop)
        layoutLabelHeight = NSLayoutConstraint.height(
            view:label)
        NSLayoutConstraint.leftToRight(
            view:label,
            toView:imageView,
            constant:kLabelLeft)
        NSLayoutConstraint.rightToRight(
            view:label,
            toView:self,
            constant:kLabelRight)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        NSLayoutConstraint.size(
            view:imageView,
            constant:kImageSize)
        NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        guard
            
            let attributedText:NSAttributedString = label.attributedText
            
        else
        {
            return
        }
        
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let usableWidth:CGFloat = width - labelMargins
        let usableSize:CGSize = CGSize(width:usableWidth, height:height)
        let boundingRect:CGRect = attributedText.boundingRect(
            with:usableSize,
            options:NSStringDrawingOptions([
                NSStringDrawingOptions.usesLineFragmentOrigin,
                NSStringDrawingOptions.usesFontLeading]),
            context:nil)
        layoutLabelHeight.constant = ceil(boundingRect.size.height)
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func config(model:MStoreItem)
    {
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        let stringTitle:NSAttributedString = NSAttributedString(
            string:model.title,
            attributes:attrTitle)
        let stringDescr:NSAttributedString = NSAttributedString(
            string:model.descr,
            attributes:attrDescr)
        mutableString.append(stringTitle)
        mutableString.append(stringDescr)
        
        label.attributedText = mutableString
        imageView.image = model.image
        
        setNeedsLayout()
    }
}
