import UIKit
import MetalKit

class MGridVisorRenderTexturesVirusFriendly:MetalTextureRandom
{
    private let kTicksPerFrame:Int = 60
    
    init(textureLoader:MTKTextureLoader)
    {
        let images:[UIImage] = [
            #imageLiteral(resourceName: "assetTextureVirusFriendlyTargeted0"),
            #imageLiteral(resourceName: "assetTextureVirusFriendlyTargeted1"),
            #imageLiteral(resourceName: "assetTextureVirusFriendlyTargeted2"),
            #imageLiteral(resourceName: "assetTextureVirusFriendlyTargeted3"),
            #imageLiteral(resourceName: "assetTextureVirusFriendlyTargeted4")]
        
        super.init(
            ticksPerFrame:kTicksPerFrame,
            images:images,
            textureLoader:textureLoader)
    }
}
