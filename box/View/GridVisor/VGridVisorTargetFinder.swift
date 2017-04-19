import UIKit

class VGridVisorTargetFinder:UIView
{
    private weak var controller:CGridVisor!
    private var initialRadius:CGFloat
    private var innerInitialRadius:CGFloat
    private var lineTotal:CGFloat
    private var innerLineTotal:CGFloat
    private let kPi2:CGFloat
    private let kRadius:CGFloat = 100
    private let kInnerRadius:CGFloat = 94
    private let kLineWidth:CGFloat = 5
    private let kLineRadius:CGFloat = 0.03
    private let kInnerLineRadius:CGFloat = 0.49
    private let kLineSeparation:CGFloat = 0.1352
    private let kRadiusDelta:CGFloat = 0.009
    
    init(controller:CGridVisor)
    {
        initialRadius = 0
        innerInitialRadius = 0
        lineTotal = kLineRadius + kLineSeparation
        innerLineTotal = kInnerLineRadius + kLineSeparation
        kPi2 = CGFloat.pi + CGFloat.pi
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func draw(_ rect:CGRect)
    {
        if let _:MGridAlgoItem = controller.targeting
        {
            guard
            
                let context:CGContext = UIGraphicsGetCurrentContext()
            
            else
            {
                return
            }
            
            let width:CGFloat = rect.maxX
            let height:CGFloat = rect.maxY
            let width_2:CGFloat = width / 2.0
            let height_2:CGFloat = height / 2.0
            let center:CGPoint = CGPoint(
                x:width_2,
                y:height_2)
            
            context.setLineWidth(kLineWidth)
            context.setStrokeColor(UIColor.gridBlue.cgColor)
            
            var currentRadius:CGFloat = initialRadius
            let maximumRadius:CGFloat = currentRadius + kPi2
            
            while currentRadius < maximumRadius
            {
                context.addArc(
                    center:center,
                    radius:kRadius,
                    startAngle:currentRadius,
                    endAngle:currentRadius + kLineRadius,
                    clockwise:false)
                context.drawPath(using:CGPathDrawingMode.stroke)
                currentRadius += lineTotal
            }
            
            currentRadius = innerInitialRadius
            let minimumRadius:CGFloat = currentRadius - kPi2
            
            while currentRadius > minimumRadius
            {
                context.addArc(
                    center:center,
                    radius:kInnerRadius,
                    startAngle:currentRadius,
                    endAngle:currentRadius - kInnerLineRadius,
                    clockwise:true)
                context.drawPath(using:CGPathDrawingMode.stroke)
                currentRadius -= innerLineTotal
            }
            
            if initialRadius >= lineTotal
            {
                initialRadius = 0
            }
            else
            {
                initialRadius += kRadiusDelta
            }
            
            if innerInitialRadius < -innerLineTotal
            {
                innerInitialRadius = 0
            }
            else
            {
                innerInitialRadius -= kRadiusDelta
            }
        }
    }
}
