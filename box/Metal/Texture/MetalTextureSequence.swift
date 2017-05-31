import UIKit
import MetalKit

class MetalTextureSequence:MetalTexture
{
    override func changeFrame()
    {
        currentFrame += 1
        
        if currentFrame >= totalFrames
        {
            currentFrame = 0
        }
    }
}
