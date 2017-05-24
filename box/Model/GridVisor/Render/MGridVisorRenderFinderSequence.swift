import UIKit
import MetalKit

class MGridVisorRenderFinderSequence:MetalTextureSequence
{
    private let kTicksPerFrame:Int = 4
    
    init(textureLoader:MTKTextureLoader)
    {
        let images:[UIImage] = [
            #imageLiteral(resourceName: "assetTextureTarget00"),
            #imageLiteral(resourceName: "assetTextureTarget01"),
            #imageLiteral(resourceName: "assetTextureTarget02"),
            #imageLiteral(resourceName: "assetTextureTarget03"),
            #imageLiteral(resourceName: "assetTextureTarget04"),
            #imageLiteral(resourceName: "assetTextureTarget05"),
            #imageLiteral(resourceName: "assetTextureTarget06"),
            #imageLiteral(resourceName: "assetTextureTarget07"),
            #imageLiteral(resourceName: "assetTextureTarget08"),
            #imageLiteral(resourceName: "assetTextureTarget09"),
            #imageLiteral(resourceName: "assetTextureTarget10"),
            #imageLiteral(resourceName: "assetTextureTarget11"),
            #imageLiteral(resourceName: "assetTextureTarget12")
        ]
        
        super.init(
            ticksPerFrame:kTicksPerFrame,
            images:images,
            textureLoader:textureLoader)
    }
}
