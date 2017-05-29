import UIKit

class MGridVisorMatchAnimation
{
    var items:[MGridVisorMatchAnimationItem]
    private var maxX:CGFloat
    private var maxY:CGFloat
    private var attributes:[String:AnyObject]
    private let minX:CGFloat
    private let minY:CGFloat
    private let countPossibleItems:UInt32
    private let kMargin:CGFloat = 50.0
    private let kSpeedDivisor:CGFloat = 20.0
    private let kFontSize:CGFloat = 13.0
    private let kPossibleItems:[String] = ["0","1"]
    private let kMaxAlpha:UInt32 = 9
    private let kMinAlpha:UInt32 = 3
    private let kMaxSpeed:UInt32 = 40
    private let kMinSpeed:UInt32 = 1
    private let kInitialItems:Int = 80
    
    init()
    {
        countPossibleItems = UInt32(kPossibleItems.count)
        items = []
        minX = -kMargin
        minY = -kMargin
        maxX = 0
        maxY = 0
        attributes = [NSFontAttributeName:UIFont.bold(size:kFontSize)]
    }
    
    //MARK: private
    
    private func randomX() -> CGFloat
    {
        let sumX:UInt32 = UInt32(maxX - minX)
        let randomX:UInt32 = arc4random_uniform(sumX)
        let floatX:CGFloat = CGFloat(randomX)
        let realX:CGFloat = floatX + minX
        
        return realX
    }
    
    private func randomY() -> CGFloat
    {
        let sumY:UInt32 = UInt32(maxY - minY)
        let randomY:UInt32 = arc4random_uniform(sumY)
        let floatY:CGFloat = CGFloat(randomY)
        let realY:CGFloat = floatY + minY
        
        return realY
    }
    
    private func randomAlpha() -> CGFloat
    {
        let totalAlpha:UInt32 = kMaxAlpha - kMinAlpha
        let random:UInt32 = arc4random_uniform(totalAlpha)
        let realAlpha:UInt32 = random + kMinAlpha
        let floatAlpha:CGFloat = CGFloat(realAlpha) / kSpeedDivisor
        
        return floatAlpha
    }
    
    private func randomItem() -> String
    {
        let itemIndex:UInt32 = arc4random_uniform(countPossibleItems)
        let itemIndexInt:Int = Int(itemIndex)
        let item:String = kPossibleItems[itemIndexInt]
        
        return item
    }
    
    private func randomSpeed() -> CGFloat
    {
        let totalSpeed:UInt32 = kMaxSpeed - kMinSpeed
        let random:UInt32 = arc4random_uniform(totalSpeed)
        let realSpeed:UInt32 = random + kMinSpeed
        let floatSpeed:CGFloat = CGFloat(realSpeed) / 10.0
        
        return floatSpeed
    }
    
    private func createItem()
    {
        let positionX:CGFloat = randomX()
        let positionY:CGFloat = randomY()
        let direction:MGridVisorMatchAnimationItem.Direction = MGridVisorMatchAnimationItem.randomDirection()
        let alpha:CGFloat = randomAlpha()
        let speed:CGFloat = randomSpeed()
        let itemString:String = randomItem()
        
        attributes[NSForegroundColorAttributeName] = UIColor.gridBlue.withAlphaComponent(alpha)
        let attributedString:NSAttributedString = NSAttributedString(
            string:itemString,
            attributes:attributes)
        
        let item:MGridVisorMatchAnimationItem = MGridVisorMatchAnimationItem(
            item:attributedString,
            speed:speed,
            direction:direction,
            posX:positionX,
            posY:positionY)
        
        items.append(item)
    }
    
    private func validItem(item:MGridVisorMatchAnimationItem) -> Bool
    {
        if item.posX < minX
        {
            return false
        }
        
        if item.posX > maxX
        {
            return false
        }
        
        return true
    }
    
    //MARK: public
    
    func initialElements(width:CGFloat, height:CGFloat)
    {
        maxX = width + kMargin
        maxY = height + kMargin
        
        for _:Int in 0 ..< kInitialItems
        {
            createItem()
        }
    }
    
    func tick(context:CGContext)
    {
        createItem()
        
        var items:[MGridVisorMatchAnimationItem] = []
        
        for item:MGridVisorMatchAnimationItem in self.items
        {
            item.move()
            
            if validItem(item:item)
            {
                item.draw(context:context)
                items.append(item)
            }
        }
        
        self.items = items
    }
}
