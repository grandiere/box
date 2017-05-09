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
            NSLocalizedString("VSettingsCellDistance_segmentedMetres", comment:""),
            NSLocalizedString("VSettingsCellDistance_segmentedFeet", comment:"")]
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
        let distance:MDistanceProtocol
        
        if selected == 0
        {
            distance = MDistanceMetre()
        }
        else
        {
            distance = MDistanceFoot()
        }
        
        MSession.sharedInstance.settings?.changeDistance(
            distance:distance)
    }
    
    //MARK: private
    
    private func updateSegmented()
    {
        guard
        
            let currentDistance:MDistanceProtocol = MSession.sharedInstance.settings?.currentDistance()
        
        else
        {
            return
        }
        
        let index:Int
        
        if let _:MDistanceFoot = currentDistance as? MDistanceFoot
        {
            index = 1
        }
        else
        {
            index = 0
        }
        
        segmented.selectedSegmentIndex = index
    }
}
