import UIKit
import MetalKit

extension MTKTextureLoader
{
    func loadImage(image:UIImage) -> MTLTexture?
    {
        guard
            
            let cGImage:CGImage = image.cgImage
            
        else
        {
            return nil
        }
        
        let texture:MTLTexture? = loadCGImage(
            cGImage:cGImage)
        return texture
    }
    
    func loadCGImage(cGImage:CGImage) -> MTLTexture?
    {
        let texture:MTLTexture
        
        do
        {
            try texture = newTexture(
                with:cGImage,
                options:[
                    MTKTextureLoaderOptionTextureUsage:
                        MetalConstants.kTextureUsage,
                    MTKTextureLoaderOptionSRGB:
                        MetalConstants.kTextureSrgb])
        }
        catch
        {
            return nil
        }
        
        return texture
    }
}
