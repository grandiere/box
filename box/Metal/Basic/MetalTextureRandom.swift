import UIKit
import MetalKit

class MetalTextureRandom:MetalTextureProtocol
{
    private var currentFrame:Int
    private var frameTick:Int
    private let frames:[MTLTexture]
    private let ticksPerFrame:Int
    private let totalFrames:UInt32
    
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
        totalFrames = UInt32(frames.count)
    }
    
    func current() -> MTLTexture?
    {
        if totalFrames < 1
        {
            return nil
        }
        
        frameTick += 1
        
        if frameTick >= ticksPerFrame
        {
            frameTick = 0
            
            let randomFrame:UInt32 = arc4random_uniform(totalFrames)
            currentFrame = Int(randomFrame)
        }
        
        let texture:MTLTexture = frames[currentFrame]
        
        return texture
    }
}
