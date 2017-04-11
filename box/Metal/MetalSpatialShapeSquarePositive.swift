import Foundation
import MetalKit

class MetalSpatialShapeSquarePositive:MetalSpatialShapeSquare
{
    init(
        device:MTLDevice,
        width:Float,
        height:Float)
    {
        let direction:MetalSpatialDirectionPositive = MetalSpatialDirectionPositive()
        
        super.init(
            device:device,
            width:width,
            height:height,
            direction:direction)
    }
}
