import UIKit
import MetalKit

class MGridVisorRenderVertexes
{
    let vertexStandby:MetalSpatialShapeSquare
    let vertexTargeted:MetalSpatialShapeSquare
    
    init(device:MTLDevice)
    {
        let imageStandby:UIImage = #imageLiteral(resourceName: "assetTextureAidStandBy")
        let imageTargeted:UIImage = #imageLiteral(resourceName: "assetTextureAidTargeted0")
        let standbyWidth:Float = Float(imageStandby.size.width)
        let standbyHeight:Float = Float(imageStandby.size.height)
        let targetedWidth:Float = Float(imageTargeted.size.width)
        let targetedHeight:Float = Float(imageTargeted.size.height)
        
        vertexStandby = MetalSpatialShapeSquarePositive(
            device:device,
            width:standbyWidth,
            height:standbyHeight)
        vertexTargeted = MetalSpatialShapeSquarePositive(
            device:device,
            width:targetedWidth,
            height:targetedHeight)
    }
}
