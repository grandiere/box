import UIKit

class VGridVisorDetailCellDistance:VGridVisorDetailCell
{
    private weak var labelKm:UILabel!
    private weak var viewAccuracy:VGridVisorDetailCellDistanceAccuracy?
    private let numberFormatter:NumberFormatter
    private let kSuffix:String = "km"
    private let kMaxDecimals:Int = 3
    private let kMinIntegers:Int = 1
    private let kTitleLeft:CGFloat = 10
    private let kTitleWidth:CGFloat = 240
    private let kAccuracyWidth:CGFloat = 65
    private let kKmWidth:CGFloat = 160
    private let kKmRight:CGFloat = 5
    
    override init(frame:CGRect)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.minimumIntegerDigits = kMinIntegers
        numberFormatter.maximumFractionDigits = kMaxDecimals
        numberFormatter.positiveSuffix = kSuffix
        
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:14),
            NSForegroundColorAttributeName:UIColor.black]
        let attributesSubtitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:12),
            NSForegroundColorAttributeName:UIColor.black]
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        let stringTitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VGridVisorDetailCellDistance_labelTitle", comment:""),
            attributes:attributesTitle)
        let stringSubtitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VGridVisorDetailCellDistance_labelSubtitle", comment:""),
            attributes:attributesSubtitle)
        
        mutableString.append(stringTitle)
        mutableString.append(stringSubtitle)
        
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.numberOfLines = 0
        labelTitle.attributedText = mutableString
        
        let labelKm:UILabel = UILabel()
        labelKm.translatesAutoresizingMaskIntoConstraints = false
        labelKm.isUserInteractionEnabled = false
        labelKm.backgroundColor = UIColor.clear
        labelKm.font = UIFont.numeric(size:15)
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
    
    override func config(model:MGridVisorDetailItem)
    {
        self.viewAccuracy?.removeFromSuperview()
        
        guard
        
            let modelDistance:MGridVisorDetailItemDistance = model as? MGridVisorDetailItemDistance,
            let distance:Double = modelDistance.distance,
            let stringDistance:String = numberFormatter.string(
                from:distance as NSNumber)
        
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
