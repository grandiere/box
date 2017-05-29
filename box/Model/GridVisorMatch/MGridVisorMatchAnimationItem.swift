import UIKit

class MGridVisorMatchAnimationItem
{
    enum Direction:CGFloat
    {
        case left = -1
        case right = 1
    }
    
    let direction:Direction
    let item:String
    let alpha:CGFloat
    var posX:CGFloat
    var posY:CGFloat
    
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
        item:String,
        alpha:CGFloat,
        direction:Direction,
        posX:CGFloat,
        posY:CGFloat)
    {
        self.item = item
        self.alpha = alpha
        self.direction = direction
        self.posX = posX
        self.posY = posY
    }
}
