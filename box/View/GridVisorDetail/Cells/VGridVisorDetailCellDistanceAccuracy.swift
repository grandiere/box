import UIKit

class VGridVisorDetailCellDistanceAccuracy:UIView
{
    private let endingX:CGFloat
    private let kDotRadius:CGFloat = 9
    private let kRadius:CGFloat = 80
    private let kCircleLine:CGFloat = 2
    private let kLineWidth:CGFloat = 3
    private let kBackgroundInitial:CGFloat = 0
    private let kBackgroundEnding:CGFloat = -0.0001
    
    init(distance:Double)
    {
        var maxDistance:Double = 1
        
        if let visorRange:Double = MSession.sharedInstance.settings?.visorRange()
        {
            maxDistance = visorRange
        }
        
        var endingPercentage:CGFloat = CGFloat(distance / maxDistance)
        
        if endingPercentage > 1
        {
            endingPercentage = 1
        }
        
        endingX = endingPercentage * kRadius
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
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
        
        let width:CGFloat = rect.maxX
        let height:CGFloat = rect.maxY
        let width_2:CGFloat = width / 2.0
        let height_2:CGFloat = height / 2.0
        let center:CGPoint = CGPoint(x:width_2, y:height_2)
        let endingPoint:CGPoint = CGPoint(x:width_2 + endingX, y:height_2)
        
        context.setLineWidth(kCircleLine)
        context.setStrokeColor(UIColor.gridGreen.cgColor)
        
        context.addArc(
            center:center,
            radius:kRadius,
            startAngle:kBackgroundInitial,
            endAngle:kBackgroundEnding,
            clockwise:false)
        context.drawPath(using:CGPathDrawingMode.stroke)
        
        context.setLineWidth(kLineWidth)
        context.setStrokeColor(UIColor.gridBlue.cgColor)
        context.setFillColor(UIColor.gridBlue.cgColor)
        
        context.addArc(
            center:center,
            radius:kDotRadius,
            startAngle:kBackgroundInitial,
            endAngle:kBackgroundEnding,
            clockwise:false)
        
        context.drawPath(using:CGPathDrawingMode.fill)
        
        context.move(to:center)
        context.addLine(to:endingPoint)
        context.drawPath(using:CGPathDrawingMode.stroke)
        
        context.setFillColor(UIColor.gridOrange.cgColor)
        
        context.addArc(
            center:endingPoint,
            radius:kDotRadius,
            startAngle:kBackgroundInitial,
            endAngle:kBackgroundEnding,
            clockwise:false)
        
        context.drawPath(using:CGPathDrawingMode.fill)
    }
}
