import UIKit
import MetalKit

class MGridVisorRenderAlgoItem
{
    let spatialSquare:MetalSpatialShapeSquarePositive
    private let textureStandBy:MTLTexture
    private let textureTargeted:MTLTexture
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
    
    //MARK: public
    
    func modeStandBy()
    {
        currentTexture = textureStandBy
    }
    
    func modeTargeted()
    {
        currentTexture = textureTargeted
    }
}
