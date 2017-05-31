import MetalKit

protocol MetalTextureProtocol
{
    func current() -> MTLTexture?
    func restart()
}
