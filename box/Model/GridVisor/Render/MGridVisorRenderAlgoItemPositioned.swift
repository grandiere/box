import Foundation

class MGridVisorRenderAlgoItemPositioned
{
    weak var item:MGridVisorRenderAlgoItem!
    let position:MetalPosition
    let deltaPosition:Float?
    static let kMaxPositionTarget:Float = 70
    
    init?(
        orientation:MGridVisorOrientation,
        item:MGridVisorRenderAlgoItem,
        userHeading:Float,
        moveVertical:Float)
    {
        let itemHeading:Float = item.model.heading
        
        guard
            
            let position:MetalPosition = orientation.itemPosition(
                userHeading:userHeading,
                moveVertical:moveVertical,
                itemHeading:itemHeading)
            
        else
        {
            return nil
        }
        
        self.item = item
        self.position = position
        
        let absoluteX:Float = abs(position.positionX)
        let absoluteY:Float = abs(position.positionY)
        
        if absoluteX < MGridVisorRenderAlgoItemPositioned.kMaxPositionTarget && absoluteY < MGridVisorRenderAlgoItemPositioned.kMaxPositionTarget
        {
            deltaPosition = absoluteX
        }
        else
        {
            deltaPosition = nil
        }
    }
}
