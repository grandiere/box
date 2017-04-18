import UIKit

class VGridVisorTargetFinder:UIView
{
    private weak var controller:CGridVisor!
    private var initialRadius:CGFloat
    private var lineTotal:CGFloat
    private let kPi2:CGFloat
    private let kRadius:CGFloat = 100
    private let kLineWidth:CGFloat = 7
    private let kLineRadius:CGFloat = 0.07
    private let kLineSeparation:CGFloat = 0.1
    private let kRadiusDelta:CGFloat = 0.005
    
    init(controller:CGridVisor)
    {
        initialRadius = 0
        lineTotal = kLineRadius + kLineSeparation
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
        if true
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
            let center:CGPoint = CGPoint(x:width_2, y:height_2)
            
            context.setLineCap(CGLineCap.round)
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
            
            if initialRadius >= lineTotal
            {
                initialRadius = 0
            }
            else
            {
                initialRadius += kRadiusDelta
            }
        }
    }
}
