import UIKit

class VGridVisorDetailCellDistance:VGridVisorDetailCell
{
    private weak var labelKm:UILabel!
    private weak var viewAccuracy:VGridVisorDetailCellDistanceAccuracy?
    private let numberFormatter:NumberFormatter
    private let kSuffix:String = "m"
    private let kMaxDecimals:Int = 1
    private let kMinIntegers:Int = 1
    private let kTitleLeft:CGFloat = 10
    private let kTitleWidth:CGFloat = 240
    private let kAccuracyWidth:CGFloat = 80
    private let kKmWidth:CGFloat = 160
    private let kKmRight:CGFloat = 5
    
    override init(frame:CGRect)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.minimumIntegerDigits = kMinIntegers
        numberFormatter.maximumFractionDigits = kMaxDecimals
        
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textColor = UIColor.black
        labelTitle.font = UIFont.bold(size:16)
        labelTitle.text = NSLocalizedString("VGridVisorDetailCellDistance_labelTitle", comment:"")
        
        let labelKm:UILabel = UILabel()
        labelKm.translatesAutoresizingMaskIntoConstraints = false
        labelKm.isUserInteractionEnabled = false
        labelKm.backgroundColor = UIColor.clear
        labelKm.font = UIFont.numeric(size:16)
        labelKm.textColor = UIColor.black
        labelKm.textAlignment = NSTextAlignment.right
        self.labelKm = labelKm
        
        addSubview(labelTitle)
        addSubview(labelKm)
        
        NSLayoutConstraint.equalsVertical(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:labelTitle,
            toView:self,
            constant:kTitleLeft)
        NSLayoutConstraint.width(
            view:labelTitle,
            constant:kTitleWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:labelKm,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:labelKm,
            toView:self,
            constant:-(kAccuracyWidth - kKmRight))
        NSLayoutConstraint.width(
            view:labelKm,
            constant:kKmWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(controller:CGridVisorDetail, model:MGridVisorDetailItem)
    {
        super.config(controller:controller, model:model)
        self.viewAccuracy?.removeFromSuperview()
        
        guard
        
            let modelDistance:MGridVisorDetailItemDistance = model as? MGridVisorDetailItemDistance,
            let distanceMetric:MDistanceProtocol = MSession.sharedInstance.settings?.currentDistance(),
            let distance:Double = modelDistance.distance
        
        else
        {
            return
        }
        
        numberFormatter.positiveSuffix = distanceMetric.shortName
        let distanceConverted:Double = distanceMetric.convertFromStandard(standard:distance)
        let distanceNumber:NSNumber = distanceConverted as NSNumber
        
        guard
            
            let stringDistance:String = numberFormatter.string(
                from:distanceNumber)
        
        else
        {
            return
        }
        
        labelKm.text = stringDistance
        
        let viewAccuracy:VGridVisorDetailCellDistanceAccuracy = VGridVisorDetailCellDistanceAccuracy(
            distance:distance)
        self.viewAccuracy = viewAccuracy
        
        addSubview(viewAccuracy)
        
        NSLayoutConstraint.equalsVertical(
            view:viewAccuracy,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:viewAccuracy,
            toView:self)
        NSLayoutConstraint.width(
            view:viewAccuracy,
            constant:kAccuracyWidth)
    }
}
