import UIKit
import MetalKit

class MGridVisorRenderTexturesVirusFoe:MetalTextureRandom
{
    private let kTicksPerFrame:Int = 60
    
    init(textureLoader:MTKTextureLoader)
    {
        let images:[UIImage] = [
            #imageLiteral(resourceName: "assetTextureVirusFoeTargeted0"),
            #imageLiteral(resourceName: "assetTextureVirusFoeTargeted1"),
            #imageLiteral(resourceName: "assetTextureVirusFoeTargeted2"),
            #imageLiteral(resourceName: "assetTextureVirusFoeTargeted3"),
            #imageLiteral(resourceName: "assetTextureVirusFoeTargeted4")]
        
        super.init(
            ticksPerFrame:kTicksPerFrame,
            images:images,
            textureLoader:textureLoader)
    }
}
