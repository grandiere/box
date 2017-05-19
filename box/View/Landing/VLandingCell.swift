import UIKit

class VLandingCell:UICollectionViewCell
{
    private weak var icon:UIImageView!
    private weak var label:UILabel!
    private let kLabelHeight:CGFloat = 90
    private let kAlphaSelected:CGFloat = 0.4
    private let kAlphaNotSelected:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
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
        label.textAlignment = NSTextAlignment.center
        self.label = label
        
        addSubview(icon)
        addSubview(label)
        
        NSLayoutConstraint.equals(
            view:icon,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:label,
            toView:self)
        NSLayoutConstraint.height(
            view:label,
            constant:kLabelHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self)
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
            icon.alpha = kAlphaSelected
            label.textColor = UIColor.gridOrange
        }
        else
        {
            icon.alpha = kAlphaNotSelected
            label.textColor = UIColor.white
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
