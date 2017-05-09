import UIKit

class VStoreHeader:UICollectionReusableView
{
    private let attrTitle:[String:Any]
    private let attrDescr:[String:Any]
    private let labelMargin2:CGFloat
    private weak var label:UILabel!
    private weak var layoutLabelHeight:NSLayoutConstraint!
    private let kLabelTop:CGFloat = 16
    private let kLabelMargin:CGFloat = 10
    private let kBorderHeight:CGFloat = 1
    
    override init(frame:CGRect)
    {
        attrTitle = [
            NSFontAttributeName:UIFont.bold(size:20),
            NSForegroundColorAttributeName:UIColor.white]
        
        attrDescr = [
            NSFontAttributeName:UIFont.regular(size:15),
            NSForegroundColorAttributeName:UIColor.white]
        labelMargin2 = kLabelMargin + kLabelMargin
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        self.label = label
        
        let border:VBorder = VBorder(color:UIColor(white:1, alpha:0.3))
        
        addSubview(label)
        addSubview(border)
        
        NSLayoutConstraint.topToTop(
            view:label,
            toView:self,
            constant:kLabelTop)
        layoutLabelHeight = NSLayoutConstraint.height(
            view:label)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self,
            margin:kLabelMargin)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
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
        let usableWidth:CGFloat = width - labelMargin2
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
        
        setNeedsLayout()
    }
}
