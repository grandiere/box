import UIKit
import MetalKit

class MGridVisorRenderTexturesVirusFoe:MetalTextureRandom
{
    private let kTicksPerFrame:Int = 60
    
    init(textureLoader:MTKTextureLoader)
    {
        let images:[UIImage] = [
            #imageLiteral(resourceName: "assetTextureVirusFoeTargeted")]
        
        super.init(
            ticksPerFrame:kTicksPerFrame,
            images:images,
            textureLoader:textureLoader)
    }
}
