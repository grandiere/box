import UIKit

class VLandingCell:UICollectionViewCell
{
    private weak var icon:UIImageView!
    private weak var label:UILabel!
    private let kIconWidth:CGFloat = 100
    private let kLabelWidth:CGFloat = 200
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        
        let icon:UIImageView = UIImageView()
        icon.isUserInteractionEnabled = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = UIViewContentMode.center
        icon.clipsToBounds = true
        self.icon = icon
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.bold(size:14)
        label.textColor = UIColor(white:1, alpha:0.85)
        self.label = label
        
        addSubview(icon)
        addSubview(label)
        
        NSLayoutConstraint.equalsVertical(
            view:icon,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:icon,
            toView:self)
        NSLayoutConstraint.width(
            view:icon,
            constant:kIconWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:label,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:label,
            toView:icon)
        NSLayoutConstraint.width(
            view:label,
            constant:kLabelWidth)
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
            backgroundColor = UIColor(white:1, alpha:0.15)
        }
        else
        {
            backgroundColor = UIColor.clear
        }
    }
    
    //MARK: public
    
    func config(model:MLandingItem)
    {
        icon.image = model.icon
        label.text = model.title
        hover()
    }
}
