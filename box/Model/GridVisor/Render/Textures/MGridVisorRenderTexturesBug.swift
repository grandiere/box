import UIKit
import MetalKit

class MGridVisorRenderTexturesBug:MetalTextureSequence
{
    private let kTicksPerFrame:Int = 10
    
    init(textureLoader:MTKTextureLoader)
    {
        let images:[UIImage] = [
            #imageLiteral(resourceName: "assetTextureBugTargeted")]
        
        super.init(
            ticksPerFrame:kTicksPerFrame,
            images:images,
            textureLoader:textureLoader)
    }
}
