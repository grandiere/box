import UIKit

class MGridVisorMatchAnimationItem
{
    enum Direction:CGFloat
    {
        case left = -1
        case right = 1
    }
    
    var posX:CGFloat
    var posY:CGFloat
    private let item:NSAttributedString
    private let deltaSpeed:CGFloat
    private let kWidth:CGFloat = 16
    private let kHeight:CGFloat = 16
    
    class func randomDirection() -> Direction
    {
        let random:UInt32 = arc4random_uniform(2)
        
        if random == 0
        {
            return Direction.left
        }
        
        return Direction.right
    }
    
    init(
        item:NSAttributedString,
        speed:CGFloat,
        direction:Direction,
        posX:CGFloat,
        posY:CGFloat)
    {
        self.item = item
        self.posX = posX
        self.posY = posY
        deltaSpeed = speed * direction.rawValue
    }
    
    //MARK: public
    
    func move()
    {
        posX += deltaSpeed
    }
    
    func draw(context:CGContext)
    {
        let rect:CGRect = CGRect(
            x:posX,
            y:posY,
            width:kWidth,
            height:kHeight)
        
        item.draw(in:rect)
    }
}
