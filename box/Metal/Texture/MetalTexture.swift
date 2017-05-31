import UIKit
import MetalKit

class MetalTexture
{
    let totalFrames:Int
    var currentFrame:Int
    private var frameTick:Int
    private let frames:[MTLTexture]
    private let ticksPerFrame:Int
    
    init(
        ticksPerFrame:Int,
        images:[UIImage],
        textureLoader:MTKTextureLoader)
    {
        self.ticksPerFrame = ticksPerFrame
        currentFrame = 0
        frameTick = 0
        
        var frames:[MTLTexture] = []
        
        for image:UIImage in images
        {
            guard
                
                let texture:MTLTexture = textureLoader.loadImage(image:image)
                
            else
            {
                continue
            }
            
            frames.append(texture)
        }
        
        self.frames = frames
        totalFrames = frames.count
    }
    
    //MARK: public
    
    func changeFrame()
    {
    }
    
    //MARK final
    
    final func current() -> MTLTexture?
    {
        if totalFrames < 1
        {
            return nil
        }
        
        frameTick += 1
        
        if frameTick >= ticksPerFrame
        {
            frameTick = 0
            changeFrame()
        }
        
        let texture:MTLTexture = frames[currentFrame]
        
        return texture
    }
    
    final func restart()
    {
        currentFrame = 0
        frameTick = 0
    }
}
