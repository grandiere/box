import UIKit

class VSettingsCellDistance:VSettingsCell
{
    private weak var segmented:UISegmentedControl!
    private let kLabelLeft:CGFloat = 10
    private let kLabelWidth:CGFloat = 200
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.font = UIFont.regular(size:15)
        labelTitle.textColor = UIColor.white
        labelTitle.text = NSLocalizedString("VSettingsCellDistance_labelTitle", comment:"")
        
        let segmentedItems:[String] = [
            NSLocalizedString("VSettingsCellDistance_segmentedMeters", comment:""),
            NSLocalizedString("VSettingsCellDistance_segmentedMiles", comment:"")]
        let segmented:UISegmentedControl = UISegmentedControl(
            items:segmentedItems)
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.clipsToBounds = true
        segmented.tintColor = UIColor.gridBlue
        
        addSubview(labelTitle)
        
        NSLayoutConstraint.equalsVertical(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:labelTitle,
            toView:self,
            constant:kLabelLeft)
        NSLayoutConstraint.width(
            view:labelTitle,
            constant:kLabelWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
