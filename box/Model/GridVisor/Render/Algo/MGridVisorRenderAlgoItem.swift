import Foundation
import MetalKit

class MGridVisorRenderAlgoItem
{
    let position:MetalPosition
    let deltaHorizontal:Float
    let deltaVertical:Float
    let positionBuffer:MTLBuffer
    private(set) weak var model:MGridAlgoItem!
    
    init(
        device:MTLDevice,
        model:MGridAlgoItem,
        position:MetalPosition)
    {
        self.model = model
        self.position = position
        deltaHorizontal = abs(position.positionX)
        deltaVertical = abs(position.positionY)
        
        positionBuffer = device.generateBuffer(
            bufferable:position)
    }
}
