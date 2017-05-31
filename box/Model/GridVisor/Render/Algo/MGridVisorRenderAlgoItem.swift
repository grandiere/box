import Foundation
import MetalKit

class MGridVisorRenderAlgoItem
{
    let position:MetalPosition
    let deltaPosition:Float
    let positionBuffer:MTLBuffer
    private(set) weak var model:MGridAlgoItem!
    
    init(
        device:MTLDevice,
        model:MGridAlgoItem,
        position:MetalPosition)
    {
        self.model = model
        self.position = position
        deltaPosition = abs(position.positionX)
        positionBuffer = device.generateBuffer(
            bufferable:position)
    }
}
