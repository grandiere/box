import UIKit
import MetalKit

class MGridVisorRenderTextures
{
    let standbyAid:MTLTexture?
    let standbyBug:MTLTexture?
    let standbyVirusFoe:MTLTexture?
    let standbyVirusFriendly:MTLTexture?
    let targetedAid:MGridVisorRenderTexturesAid
    let targetedBug:MGridVisorRenderTexturesBug
    let targetedVirusFoe:MGridVisorRenderTexturesVirusFoe
    let targetedVirusFriendly:MGridVisorRenderTexturesVirusFriendly
    
    init(textureLoader:MTKTextureLoader)
    {
        standbyAid = textureLoader.loadImage(
            image:#imageLiteral(resourceName: "assetTextureAidStandBy"))
        standbyBug = textureLoader.loadImage(
            image:#imageLiteral(resourceName: "assetTextureBugStandBy"))
        standbyVirusFoe = textureLoader.loadImage(
            image:#imageLiteral(resourceName: "assetTextureVirusFoeStandBy"))
        standbyVirusFriendly = textureLoader.loadImage(
            image:#imageLiteral(resourceName: "assetTextureVirusFriendlyStandBy"))
        
        targetedAid = MGridVisorRenderTexturesAid(
            textureLoader:textureLoader)
        targetedBug = MGridVisorRenderTexturesBug(
            textureLoader:textureLoader)
        targetedVirusFoe = MGridVisorRenderTexturesVirusFoe(
            textureLoader:textureLoader)
        targetedVirusFriendly = MGridVisorRenderTexturesVirusFriendly(
            textureLoader:textureLoader)
    }
}
