import UIKit
import MetalKit

class MGridVisorRenderFinderSequence:MetalTextureSequence
{
    private let kTicksPerFrame:Int = 5
    
    init(textureLoader:MTKTextureLoader)
    {
        let images:[UIImage] = [
            #imageLiteral(resourceName: "assetTextureTarget01"),
            #imageLiteral(resourceName: "assetTextureTarget02"),
            #imageLiteral(resourceName: "assetTextureTarget03"),
            #imageLiteral(resourceName: "assetTextureTarget04"),
            #imageLiteral(resourceName: "assetTextureTarget05"),
            #imageLiteral(resourceName: "assetTextureTarget06"),
            #imageLiteral(resourceName: "assetTextureTarget07"),
            #imageLiteral(resourceName: "assetTextureTarget08"),
            #imageLiteral(resourceName: "assetTextureTarget09")]
        
        super.init(
            ticksPerFrame:kTicksPerFrame,
            images:images,
            textureLoader:textureLoader)
    }
}
