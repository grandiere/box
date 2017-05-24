import UIKit
import MetalKit

class MetalTextureSequence
{
    private var currentFrame:Int
    private var frameTick:Int
    private let frames:[MTLTexture]
    private let ticksPerFrame:Int
    private let totalFrames:Int
    
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
    
    //MARK: final
    
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
            
            currentFrame += 1
            
            if currentFrame >= totalFrames
            {
                currentFrame = 0
            }
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
