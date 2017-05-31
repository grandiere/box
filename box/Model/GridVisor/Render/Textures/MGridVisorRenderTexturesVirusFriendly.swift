import UIKit
import MetalKit

class MGridVisorRenderTexturesVirusFriendly:MetalTextureRandom
{
    private let kTicksPerFrame:Int = 60
    
    init(textureLoader:MTKTextureLoader)
    {
        let images:[UIImage] = [
            #imageLiteral(resourceName: "assetTextureVirusFriendlyTargeted")]
        
        super.init(
            ticksPerFrame:kTicksPerFrame,
            images:images,
            textureLoader:textureLoader)
    }
}
