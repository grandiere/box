import UIKit
import MetalKit

class MGridVisorRenderTexturesVirusFoe:MetalTextureSequence
{
    private let kTicksPerFrame:Int = 20
    
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
