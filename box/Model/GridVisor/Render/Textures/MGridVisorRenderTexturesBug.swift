import UIKit
import MetalKit

class MGridVisorRenderTexturesBug:MetalTextureSequence
{
    private let kTicksPerFrame:Int = 20
    
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
