import Foundation

class MGridVisorRenderAlgoItemPositioned
{
    weak var item:MGridVisorRenderAlgoItem!
    let position:MetalPosition
    let deltaPosition:Float?
    
    init?(
        orientation:MGridVisorOrientation,
        item:MGridVisorRenderAlgoItem,
        userHeading:Float,
        moveVertical:Float)
    {
        let itemHeading:Float = item.model.multipliedHeading
        
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
        
        if absoluteX < MGridVisorRenderAlgo.kMaxTarget && absoluteY < MGridVisorRenderAlgo.kMaxTarget
        {
            deltaPosition = absoluteX
        }
        else
        {
            deltaPosition = nil
        }
    }
}
