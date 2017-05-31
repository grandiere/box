import UIKit
import MetalKit

class MGridVisorRenderTexturesBug:MetalTextureRandom
{
    private let kTicksPerFrame:Int = 5
    
    init(textureLoader:MTKTextureLoader)
    {
        let images:[UIImage] = [
            #imageLiteral(resourceName: "assetTextureBugTargeted0"),
            #imageLiteral(resourceName: "assetTextureBugTargeted1"),
            #imageLiteral(resourceName: "assetTextureBugTargeted2"),
            #imageLiteral(resourceName: "assetTextureBugTargeted3")]
        
        super.init(
            ticksPerFrame:kTicksPerFrame,
            images:images,
            textureLoader:textureLoader)
    }
}
