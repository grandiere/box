import UIKit

class VLandingCellTheGrid:VLandingCell
{
    private let kIconWidth:CGFloat = 100
    private let kLabelWidth:CGFloat = 200
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let icon:UIImageView = UIImageView()
        icon.isUserInteractionEnabled = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = UIViewContentMode.center
        icon.clipsToBounds = true
        icon.image = #imageLiteral(resourceName: "assetGenericTheGrid")
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.bold(size:14)
        label.textColor = UIColor.white
        label.text = NSLocalizedString("VLandingCellTheGrid_title", comment:"")
        
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
}
