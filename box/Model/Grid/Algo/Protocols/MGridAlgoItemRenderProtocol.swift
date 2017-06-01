import UIKit
import MetalKit

protocol MGridAlgoItemRenderProtocol
{
    var overlayColour:UIColor { get }
    
    func textureStandby(textures:MGridVisorRenderTextures) -> MTLTexture?
    func textureTargeted(textures:MGridVisorRenderTextures) -> MTLTexture?
}
