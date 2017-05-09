import UIKit

class VSettingsCellDistance:VSettingsCell
{
    private weak var segmented:UISegmentedControl!
    private let kLabelLeft:CGFloat = 10
    private let kLabelWidth:CGFloat = 200
    private let kSegmentedTop:CGFloat = 34
    private let kSegmentedHeight:CGFloat = 32
    private let kSegmentedRight:CGFloat = -10
    private let kSegmentedWidth:CGFloat = 190
    
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
        segmented.addTarget(
            self,
            action:#selector(actionSegmented(sender:)),
            for:UIControlEvents.valueChanged)
        self.segmented = segmented
        
        addSubview(labelTitle)
        addSubview(segmented)
        
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
        
        NSLayoutConstraint.topToTop(
            view:segmented,
            toView:self,
            constant:kSegmentedTop)
        NSLayoutConstraint.height(
            view:segmented,
            constant:kSegmentedHeight)
        NSLayoutConstraint.rightToRight(
            view:segmented,
            toView:self,
            constant:kSegmentedRight)
        NSLayoutConstraint.width(
            view:segmented,
            constant:kSegmentedWidth)
        
        updateSegmented()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionSegmented(sender segmented:UISegmentedControl)
    {
        let selected:Int = segmented.selectedSegmentIndex
        let distance:DSettings.Distance
        
        if selected == 0
        {
            distance = DSettings.Distance.meters
        }
        else
        {
            distance = DSettings.Distance.miles
        }
        
        MSession.sharedInstance.settings?.changeDistance(
            distance:distance)
    }
    
    //MARK: private
    
    private func updateSegmented()
    {
        guard
        
            let currentDistance:DSettings.Distance = MSession.sharedInstance.settings?.currentDistance()
        
        else
        {
            return
        }
        
        let index:Int
        
        switch currentDistance
        {
        case DSettings.Distance.meters:
            
            index = 0
            
            break
            
        case DSettings.Distance.miles:
            
            index = 1
            
            break
        }
        
        segmented.selectedSegmentIndex = index
    }
}
