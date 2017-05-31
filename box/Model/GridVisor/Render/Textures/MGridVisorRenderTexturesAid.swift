import UIKit
import MetalKit

class MGridVisorRenderTexturesAid:MetalTextureSequence
{
    private let kTicksPerFrame:Int = 20
    
    init(textureLoader:MTKTextureLoader)
    {
        let images:[UIImage] = [
            #imageLiteral(resourceName: "assetTextureAidTargeted0"),
            #imageLiteral(resourceName: "assetTextureAidTargeted1"),
            #imageLiteral(resourceName: "assetTextureAidTargeted2"),
            #imageLiteral(resourceName: "assetTextureAidTargeted3"),
            #imageLiteral(resourceName: "assetTextureAidTargeted4"),
            #imageLiteral(resourceName: "assetTextureAidTargeted5"),
            #imageLiteral(resourceName: "assetTextureAidTargeted6")]
        
        super.init(
            ticksPerFrame:kTicksPerFrame,
            images:images,
            textureLoader:textureLoader)
    }
}
