import UIKit

class VGridVisorBarEnergy:UIView
{
    private weak var controller:CGridVisor!
    private weak var labelEnergy:UILabel!
    private var energyPercent:CGFloat
    private let circleColor:UIColor
    private let outerColor:UIColor
    private let rectOuter:CGRect
    private let rectCircle:CGRect
    private let energyCenter:CGPoint
    private let stringPercent:NSAttributedString
    private let attributesAmount:[String:AnyObject]
    private let kOuterLeft:CGFloat = 5
    private let kCircleLeft:CGFloat = 15
    private let kOuterTop:CGFloat = -90
    private let kCircleTop:CGFloat = -80
    private let kOuterSize:CGFloat = 160
    private let kCircleSize:CGFloat = 140
    private let kLabelRight:CGFloat = -5
    private let kLabelHeight:CGFloat = 48
    private let kLineWidth:CGFloat = 7
    private let kEnergyRadius:CGFloat = 80
    private let kPi_2:CGFloat = CGFloat.pi / 2.0
    
    init(controller:CGridVisor)
    {
        energyPercent = 0.5
        energyCenter = CGPoint(x:85, y:-5)
        circleColor = UIColor(white:1, alpha:0.75)
        outerColor = UIColor(white:1, alpha:0.2)
        rectOuter = CGRect(
            x:kOuterLeft,
            y:kOuterTop,
            width:kOuterSize,
            height:kOuterSize)
        rectCircle = CGRect(
            x:kCircleLeft,
            y:kCircleTop,
            width:kCircleSize,
            height:kCircleSize)
        
        let attributesPercent:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:11),
            NSForegroundColorAttributeName:UIColor.gridBlue]
        attributesAmount = [
            NSFontAttributeName:UIFont.bold(size:16),
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
        context.addEllipse(in:rectOuter)
        context.drawPath(using:CGPathDrawingMode.fill)
        
        context.setFillColor(circleColor.cgColor)
        context.addEllipse(in:rectCircle)
        context.drawPath(using:CGPathDrawingMode.fill)
        
        let radiansEnergy:CGFloat = kPi_2 * energyPercent
        let endAngle:CGFloat = radiansEnergy + kPi_2
        
        context.setLineCap(CGLineCap.round)
        context.setLineWidth(kLineWidth)
        context.setStrokeColor(UIColor.gridBlue.cgColor)
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
        let rawAmount:String = "\(energy)"
        let stringAmount:NSAttributedString = NSAttributedString(
            string:rawAmount,
            attributes:attributesAmount)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringAmount)
        mutableString.append(stringPercent)
        
        labelEnergy.attributedText = mutableString
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
