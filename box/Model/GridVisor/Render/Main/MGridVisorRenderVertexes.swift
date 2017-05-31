import UIKit
import MetalKit

class MGridVisorRenderVertexes
{
    let vertexStandby:MTLBuffer
    let vertexTargeted:MTLBuffer
    
    init(device:MTLDevice)
    {
        let imageStandby:UIImage = #imageLiteral(resourceName: "assetTextureAidStandBy")
        let imageTargeted:UIImage = #imageLiteral(resourceName: "assetTextureAidTargeted0")
        let standbyWidth:Float = Float(imageStandby.size.width)
        let standbyHeight:Float = Float(imageStandby.size.height)
        let targetedWidth:Float = Float(imageTargeted.size.width)
        let targetedHeight:Float = Float(imageTargeted.size.height)
        
        let standBy:MetalSpatialShapeSquarePositive = MetalSpatialShapeSquarePositive(
            device:device,
            width:standbyWidth,
            height:standbyHeight)
        let targeted:MetalSpatialShapeSquarePositive = MetalSpatialShapeSquarePositive(
            device:device,
            width:targetedWidth,
            height:targetedHeight)
        
        vertexStandby = standBy.vertexBuffer
        vertexTargeted = targeted.vertexBuffer
    }
}
