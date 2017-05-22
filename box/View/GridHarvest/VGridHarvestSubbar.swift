import UIKit

class VGridHarvestSubbar:UIView
{
    private let kBorderHeight:CGFloat = 1
    private let kLabelWidth:CGFloat = 88
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        backgroundColor = UIColor(white:0, alpha:0.7)
        
        let border:VBorder = VBorder(color:UIColor(white:1, alpha:0.3))
        
        let labelLevel:UILabel = UILabel()
        labelLevel.isUserInteractionEnabled = false
        labelLevel.translatesAutoresizingMaskIntoConstraints = false
        labelLevel.backgroundColor = UIColor.clear
        labelLevel.textAlignment = NSTextAlignment.center
        labelLevel.font = UIFont.regular(size:11)
        labelLevel.textColor = UIColor.white
        labelLevel.text = NSLocalizedString("VGridHarvestSubbar_labelLevel", comment:"")
        
        let labelKills:UILabel = UILabel()
        labelKills.isUserInteractionEnabled = false
        labelKills.translatesAutoresizingMaskIntoConstraints = false
        labelKills.backgroundColor = UIColor.clear
        labelKills.textAlignment = NSTextAlignment.center
        labelKills.font = UIFont.regular(size:11)
        labelKills.textColor = UIColor.white
        labelKills.text = NSLocalizedString("VGridHarvestSubbar_labelKills", comment:"")
        
        let labelAge:UILabel = UILabel()
        labelAge.isUserInteractionEnabled = false
        labelAge.translatesAutoresizingMaskIntoConstraints = false
        labelAge.backgroundColor = UIColor.clear
        labelAge.textAlignment = NSTextAlignment.center
        labelAge.font = UIFont.regular(size:11)
        labelAge.textColor = UIColor.white
        labelAge.text = NSLocalizedString("VGridHarvestSubbar_labelAge", comment:"")
        
        addSubview(border)
        addSubview(labelLevel)
        addSubview(labelKills)
        addSubview(labelAge)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        NSLayoutConstraint.equalsVertical(
            view:labelLevel,
            toView:self)
        NSLayoutConstraint.rightToLeft(
            view:labelLevel,
            toView:labelKills)
        NSLayoutConstraint.width(
            view:labelLevel,
            constant:kLabelWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:labelKills,
            toView:self)
        NSLayoutConstraint.rightToLeft(
            view:labelKills,
            toView:labelAge)
        NSLayoutConstraint.width(
            view:labelKills,
            constant:kLabelWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:labelAge,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:labelAge,
            toView:self)
        NSLayoutConstraint.width(
            view:labelAge,
            constant:kLabelWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
