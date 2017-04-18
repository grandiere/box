import UIKit
import MetalKit

class MGridVisorRenderAlgoItem
{
    let texture:MTLTexture
    let spatialSquare:MetalSpatialShapeSquarePositive
    private(set) weak var model:MGridAlgoItem!
    
    init?(
        device:MTLDevice,
        textureLoader:MTKTextureLoader,
        model:MGridAlgoItem)
    {
        self.model = model
        
        guard
            
            let texture:MTLTexture = textureLoader.loadImage(
                image:model.image)
            
        else
        {
            return nil
        }
        
        self.texture = texture
        spatialSquare = MetalSpatialShapeSquarePositive(
            device:device,
            width:model.width,
            height:model.height)
    }
}
