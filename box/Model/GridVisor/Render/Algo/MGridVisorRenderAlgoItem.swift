import Foundation

class MGridVisorRenderAlgoItem
{
    let position:MetalPosition
    let deltaPosition:Float
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
        deltaPosition = abs(position.positionX)
    }
}
