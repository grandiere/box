import UIKit
import MetalKit

class MetalTextureRandom:MetalTexture
{
    override func changeFrame()
    {
        let total:UInt32 = UInt32(totalFrames)
        let randomFrame:UInt32 = arc4random_uniform(total)
        currentFrame = Int(randomFrame)
    }
}
