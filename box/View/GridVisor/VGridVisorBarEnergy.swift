import UIKit

class VGridVisorBarEnergy:UIView
{
    private weak var controller:CGridVisor!
    private weak var labelEnergy:UILabel!
    private var energyPercent:CGFloat
    private let circleColor:UIColor
    private let outerColor:UIColor
    private let energyCenter:CGPoint
    private let stringPercent:NSAttributedString
    private let attributesAmount:[String:AnyObject]
    private let kRadiusStart:CGFloat = 0.00001
    private let kRadiusEnd:CGFloat = 0.0
    private let kLabelRight:CGFloat = -5
    private let kLabelHeight:CGFloat = 40
    private let kLineWidth:CGFloat = 8
    private let kCircleRadius:CGFloat = 65
    private let kOuterRadius:CGFloat = 73
    private let kEnergyRadius:CGFloat = 69
    private let kPi_2:CGFloat = CGFloat.pi / 2.0
    private let kEnergyThreshold:CGFloat = 0.4
    
    init(controller:CGridVisor)
    {
        energyPercent = 0
        energyCenter = CGPoint(x:85, y:-5)
        circleColor = UIColor(white:1, alpha:0.75)
        outerColor = UIColor(white:1, alpha:0.2)
        
        let attributesPercent:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:9),
            NSForegroundColorAttributeName:UIColor.black]
        attributesAmount = [
            NSFontAttributeName:UIFont.bold(size:12),
            NSForegroundColorAttributeName:UIColor.black]
        
        stringPercent = NSAttributedString(
            string:NSLocalizedString("VGridVisorBarEnergy_percent", comment:""),
            attributes:attributesPercent)
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        self.controller = controller
        
        let labelEnergy:UILabel = UILabel()
        labelEnergy.translatesAutoresizingMaskIntoConstraints = false
        labelEnergy.backgroundColor = UIColor.clear
        labelEnergy.isUserInteractionEnabled = false
        labelEnergy.textAlignment = NSTextAlignment.right
        self.labelEnergy = labelEnergy
        
        addSubview(labelEnergy)
        
        NSLayoutConstraint.topToTop(
            view:labelEnergy,
            toView:self)
        NSLayoutConstraint.height(
            view:labelEnergy,
            constant:kLabelHeight)
        NSLayoutConstraint.rightToRight(
            view:labelEnergy,
            toView:self,
            constant:kLabelRight)
        NSLayoutConstraint.leftToLeft(
            view:labelEnergy,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func draw(_ rect:CGRect)
    {
        guard
        
            let context:CGContext = UIGraphicsGetCurrentContext()
        
        else
        {
            return
        }
        
        context.setFillColor(outerColor.cgColor)
        context.addArc(
            center:energyCenter,
            radius:kOuterRadius,
            startAngle:kRadiusStart,
            endAngle:kRadiusEnd,
            clockwise:false)
        context.drawPath(using:CGPathDrawingMode.fill)
        
        context.setFillColor(circleColor.cgColor)
        context.addArc(
            center:energyCenter,
            radius:kCircleRadius,
            startAngle:kRadiusStart,
            endAngle:kRadiusEnd,
            clockwise:false)
        context.drawPath(using:CGPathDrawingMode.fill)
        
        let radiansEnergy:CGFloat = kPi_2 * energyPercent
        let endAngle:CGFloat = radiansEnergy + kPi_2
        
        context.setLineCap(CGLineCap.round)
        context.setLineWidth(kLineWidth)
        
        if energyPercent > kEnergyThreshold
        {
            context.setStrokeColor(UIColor.gridBlue.cgColor)
        }
        else
        {
            context.setStrokeColor(UIColor.gridOrange.cgColor)
        }
        
        context.addArc(
            center:energyCenter,
            radius:kEnergyRadius,
            startAngle:kPi_2,
            endAngle:endAngle,
            clockwise:false)
        context.drawPath(using:CGPathDrawingMode.stroke)
    }
    
    //MARK: private
    
    private func asyncRefresh()
    {
        guard
        
            let energy:Int = MSession.sharedInstance.settings?.energy?.percentEnergy()
        
        else
        {
            return
        }
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.updateEnergy(energy:energy)
        }
    }
    
    private func updateEnergy(energy:Int)
    {
        energyPercent = CGFloat(energy) / 100.0
        let rawAmount:String = "\(energy)"
        let stringAmount:NSAttributedString = NSAttributedString(
            string:rawAmount,
            attributes:attributesAmount)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringAmount)
        mutableString.append(stringPercent)
        labelEnergy.attributedText = mutableString
        
        setNeedsDisplay()
    }
    
    //MARK: public
    
    func refresh()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncRefresh()
        }
    }
}
