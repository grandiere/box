import UIKit

class VGridVisorDetailCellDistanceAccuracy:UIView
{
    private let distance:Double
    private let kRadius:CGFloat = 20
    private let kLineWidth:CGFloat = 7
    
    init(distance:Double)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        self.distance = distance
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
        
        
    }
}
