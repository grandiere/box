import UIKit

class VGridVisorTargetFinder:UIView
{
    private weak var controller:CGridVisor!
    private let kRadius:CGFloat = 60
    private let kLineWidth:CGFloat = 20
    
    init(controller:CGridVisor)
    {
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
            let center:CGPoint = CGPoint(x:width_2, y:height_2)
            
            context.setLineCap(CGLineCap.round)
            context.setLineWidth(kLineWidth)
            context.setFillColor(UIColor.red.cgColor)
            context.addArc(
                center:center,
                radius:kRadius,
                startAngle:0,
                endAngle:CGFloat.pi,
                clockwise:true)
            context.drawPath(using:CGPathDrawingMode.stroke)
        }
    }
}
