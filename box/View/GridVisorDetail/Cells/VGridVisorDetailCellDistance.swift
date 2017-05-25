import UIKit

class VGridVisorDetailCellDistance:VGridVisorDetailCell
{
    private weak var labelKm:UILabel!
    private weak var viewAccuracy:VGridVisorDetailCellDistanceAccuracy?
    private weak var layoutLabelTop:NSLayoutConstraint!
    private weak var layoutLabelLeft:NSLayoutConstraint!
    private let numberFormatter:NumberFormatter
    private let kMaxDecimals:Int = 0
    private let kMinIntegers:Int = 1
    private let kLabelWidth:CGFloat = 200
    private let kLabelHeight:CGFloat = 50
    private let kLabelLeft:CGFloat = 8
    
    override init(frame:CGRect)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.minimumIntegerDigits = kMinIntegers
        numberFormatter.maximumFractionDigits = kMaxDecimals
        
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let labelKm:UILabel = UILabel()
        labelKm.translatesAutoresizingMaskIntoConstraints = false
        labelKm.isUserInteractionEnabled = false
        labelKm.backgroundColor = UIColor.clear
        labelKm.font = UIFont.numeric(size:18)
        labelKm.textColor = UIColor.black
        self.labelKm = labelKm
        
        addSubview(labelKm)
        
        layoutLabelTop = NSLayoutConstraint.topToTop(
            view:labelKm,
            toView:self)
        layoutLabelLeft = NSLayoutConstraint.leftToLeft(
            view:labelKm,
            toView:self)
        NSLayoutConstraint.width(
            view:labelKm,
            constant:kLabelWidth)
        NSLayoutConstraint.height(
            view:labelKm,
            constant:kLabelHeight)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let centerX:CGFloat = bounds.midX
        let centerY:CGFloat = bounds.midY
        layoutLabelTop.constant = centerY
        layoutLabelLeft.constant = centerX - kLabelLeft
        
        super.layoutSubviews()
    }
    
    override func config(controller:CGridVisorDetail, model:MGridVisorDetailProtocol)
    {
        super.config(controller:controller, model:model)
        self.viewAccuracy?.removeFromSuperview()
        
        guard
        
            let modelDistance:MGridVisorDetailDistance = model as? MGridVisorDetailDistance,
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
        
        NSLayoutConstraint.equals(
            view:viewAccuracy,
            toView:self)
    }
}
