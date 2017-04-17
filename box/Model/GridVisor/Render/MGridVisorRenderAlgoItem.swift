import Foundation
import CoreLocation
import MetalKit

class MGridVisorRenderAlgoItem
{
    let mineHeading:Float
    let location:CLLocation
    let texture:MTLTexture
    
    init(
        location:CLLocation,
        mineHeading:Float,
        texture:MTLTexture)
    {
        self.location = location
        self.mineHeading = mineHeading
        self.texture = texture
    }
}
