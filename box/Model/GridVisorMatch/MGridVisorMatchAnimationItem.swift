import UIKit

class MGridVisorMatchAnimationItem
{
    let item:String
    let alpha:CGFloat
    var posX:CGFloat
    var posY:CGFloat
    
    init(item:String, alpha:CGFloat)
    {
        self.item = item
        self.alpha = alpha
        posX = 0
        posY = 0
    }
}
