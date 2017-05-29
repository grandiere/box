import UIKit

class MGridVisorMatchAnimation
{
    var items:[MGridVisorMatchAnimationItem]
    private var maxX:CGFloat
    private var maxY:CGFloat
    private let minX:CGFloat
    private let minY:CGFloat
    private let countPossibleItems:UInt32
    private let kMargin:CGFloat = 50
    private let kPossibleItems:[String] = ["0","1"]
    private let kCreateRatio:UInt32 = 10
    private let kMaxAlpha:UInt32 = 8
    private let kMinAlpha:UInt32 = 2
    private let kInitialItems:Int = 20
    
    init()
    {
        countPossibleItems = UInt32(kPossibleItems.count)
        items = []
        minX = -kMargin
        minY = -kMargin
        maxX = 0
        maxY = 0
    }
    
    //MARK: private
    
    private func randomX() -> CGFloat
    {
        let sumX:UInt32 = UInt32(maxX - minX)
        let randomX:UInt32 = arc4random_uniform(sumX)
        let floatX:CGFloat = CGFloat(randomX)
        let realX:CGFloat = floatX - minX
        
        return realX
    }
    
    private func randomY() -> CGFloat
    {
        let sumY:UInt32 = UInt32(maxY - minY)
        let randomY:UInt32 = arc4random_uniform(sumY)
        let floatY:CGFloat = CGFloat(randomY)
        let realY:CGFloat = floatY - minY
        
        return realY
    }
    
    private func randomAlpha() -> CGFloat
    {
        let totalAlpha:UInt32 = kMinAlpha + kMaxAlpha
        let random:UInt32 = arc4random_uniform(totalAlpha)
        let realAlpha:UInt32 = random - kMinAlpha
        let floatAlpha:CGFloat = CGFloat(realAlpha)
        
        return floatAlpha
    }
    
    private func randomItem() -> String
    {
        let itemIndex:UInt32 = arc4random_uniform(countPossibleItems)
        let itemIndexInt:Int = Int(itemIndex)
        let item:String = kPossibleItems[itemIndexInt]
        
        return item
    }
    
    private func createItem()
    {
        let positionX:CGFloat = randomX()
        let positionY:CGFloat = randomY()
        let direction:MGridVisorMatchAnimationItem.Direction = MGridVisorMatchAnimationItem.randomDirection()
        let alpha:CGFloat = randomAlpha()
        let itemString:String = randomItem()
        let item:MGridVisorMatchAnimationItem = MGridVisorMatchAnimationItem(
            item:itemString,
            alpha:alpha,
            direction:direction,
            posX:positionX,
            posY:positionY)
        
        items.append(item)
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
    
    func tick()
    {
        let shouldCreate:UInt32 = arc4random_uniform(kCreateRatio)
        
        if shouldCreate == 0
        {
            createItem()
        }
    }
}
