import UIKit

class VGridVisorDetailCellDistance:VGridVisorDetailCell
{
    private weak var labelKm:UILabel!
    private weak var labelScore:UILabel!
    private let numberFormatter:NumberFormatter
    private let kSuffix:String = " Km"
    private let kMaxDecimals:Int = 3
    private let kMinIntegers:Int = 1
    private let kTitleLeft:CGFloat = 10
    private let kTitleWidth:CGFloat = 200
    private let kAccuracyWidth:CGFloat = 80
    
    override init(frame:CGRect)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.minimumIntegerDigits = kMinIntegers
        numberFormatter.maximumFractionDigits = kMaxDecimals
        numberFormatter.positiveSuffix = kSuffix
        
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.bold(size:15)
        labelTitle.text = NSLocalizedString("VGridVisorDetailCellDistance_labelTitle", comment:"")
        labelTitle.textColor = UIColor.black
        
        let labelKm:UILabel = UILabel()
        labelKm.translatesAutoresizingMaskIntoConstraints = false
        labelKm.isUserInteractionEnabled = false
        labelKm.backgroundColor = UIColor.clear
        labelKm.font = UIFont.numeric(size:20)
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
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(model:MGridVisorDetailItem)
    {
        guard
        
            let modelDistance:MGridVisorDetailItemDistance = model as? MGridVisorDetailItemDistance,
            let distance:NSNumber = modelDistance.distance as NSNumber?,
            let stringDistance:String = numberFormatter.string(
                from:distance)
        
        else
        {
            return
        }
        
        labelKm.text = stringDistance
    }
}
