import UIKit
import MetalKit

class MGridVisorRenderAlgoItem
{
    private let textureStandby:MTLTexture
    private let textureTargeted:MTLTexture
    private let vertexStandby:MetalSpatialShapeSquare
    private let vertexTargeted:MetalSpatialShapeSquare
    private(set) weak var currentTexture:MTLTexture?
    private(set) weak var currentVertex:MetalSpatialBase?
    private(set) weak var model:MGridAlgoItem!
    
    init?(
        device:MTLDevice,
        textureLoader:MTKTextureLoader,
        model:MGridAlgoItem)
    {
        self.model = model
        
        guard
            
            let imageStandby:UIImage = model.imageStandby(),
            let imageTargeted:UIImage = model.imageTargeted(),
            let textureStandby:MTLTexture = textureLoader.loadImage(
                image:imageStandby),
            let textureTargeted:MTLTexture = textureLoader.loadImage(
                image:imageTargeted)
            
        else
        {
            return nil
        }
        
        self.textureStandby = textureStandby
        self.textureTargeted = textureTargeted
        
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
        
        modeStandBy()
    }
    
    //MARK: public
    
    func modeStandBy()
    {
        currentTexture = textureStandby
        currentVertex = vertexStandby
    }
    
    func modeTargeted()
    {
        currentTexture = textureTargeted
        currentVertex = vertexTargeted
    }
}
