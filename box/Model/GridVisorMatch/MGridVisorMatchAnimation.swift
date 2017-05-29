import UIKit

class MGridVisorMatchAnimation
{
    var items:[MGridVisorMatchAnimationItem]
    private let minX:CGFloat
    private let minY:CGFloat
    private var maxX:CGFloat
    private var maxY:CGFloat
    private let kMargin:CGFloat = 50
    private let kPossibleItems:[String] = ["0","1"]
    private let kCreateRatio:UInt32 = 10
    private let kInitialItems:Int = 20
    
    init()
    {
        items = []
        minX = -kMargin
        minY = -kMargin
        maxX = 0
        maxY = 0
    }
    
    //MARK: private
    
    private func createItem()
    {
        
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
