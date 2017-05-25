import UIKit

class VGridVisorDetailCellDistance:VGridVisorDetailCell
{
    private weak var labelKm:UILabel!
    private weak var viewAccuracy:VGridVisorDetailCellDistanceAccuracy?
    private let numberFormatter:NumberFormatter
    private let kMaxDecimals:Int = 1
    private let kMinIntegers:Int = 1
    private let kKmWidth:CGFloat = 160
    
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
        labelKm.font = UIFont.numeric(size:12)
        labelKm.textColor = UIColor.black
        labelKm.textAlignment = NSTextAlignment.right
        self.labelKm = labelKm
        
        addSubview(labelKm)
        
        NSLayoutConstraint.equalsVertical(
            view:labelKm,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:labelKm,
            toView:self)
        NSLayoutConstraint.width(
            view:labelKm,
            constant:kKmWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
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
