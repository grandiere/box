import Foundation

class MGridVisorRenderAlgoItem
{
    let position:MetalPosition
    let deltaPosition:Float?
    private(set) weak var model:MGridAlgoItem!
    private let kMaxTarget:Float = 85
    
    init?(
        orientation:MGridVisorOrientation,
        model:MGridAlgoItem,
        userHeading:Float,
        moveVertical:Float)
    {
        let itemHeading:Float = model.multipliedHeading
        
        guard
            
            let position:MetalPosition = orientation.itemPosition(
                userHeading:userHeading,
                moveVertical:moveVertical,
                itemHeading:itemHeading)
            
            else
        {
            return nil
        }
        
        self.model = model
        self.position = position
        
        let absoluteX:Float = abs(position.positionX)
        let absoluteY:Float = abs(position.positionY)
        
        if absoluteX < kMaxTarget && absoluteY < kMaxTarget
        {
            deltaPosition = absoluteX
        }
        else
        {
            deltaPosition = nil
        }
    }
}
