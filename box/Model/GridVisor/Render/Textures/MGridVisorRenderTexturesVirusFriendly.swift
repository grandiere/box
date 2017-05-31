import UIKit
import MetalKit

class MGridVisorRenderTexturesVirusFriendly:MetalTextureSequence
{
    private let kTicksPerFrame:Int = 10
    
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
