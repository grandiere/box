import Foundation

class MGridVisorRenderAlgoItem
{
    let position:MetalPosition
    let deltaPosition:Float
    private(set) weak var model:MGridAlgoItem!
    
    init(
        model:MGridAlgoItem,
        position:MetalPosition)
    {
        self.model = model
        self.position = position
        deltaPosition = abs(position.positionX)
    }
}
