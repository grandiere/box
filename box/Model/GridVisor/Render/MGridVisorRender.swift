import Foundation
import MetalKit
import ImageIO
import CoreLocation

class MGridVisorRender:MetalRenderableProtocol
{
    let background:MGridVisorRenderBackground
    let algo:MGridVisorRenderAlgo
    private let cIContext:CIContext
    private let textureLoader:MTKTextureLoader
    private let projection:MetalProjection
    
    init(
        controller:CGridVisor,
        device:MTLDevice)
    {
        textureLoader = MTKTextureLoader(device:device)
        
        cIContext = CIContext(mtlDevice:device)
        background = MGridVisorRenderBackground(device:device)
        projection = MetalProjection(device:device)
        
        algo = MGridVisorRenderAlgo(
            controller:controller,
            device:device,
            textureLoader:textureLoader)
    }
    
    //MARK: public
    
    func updateCameraImage(cIImage:CIImage)
    {
        let cameraRect:CGRect = cIImage.extent
        
        guard
            
            let cGImage:CGImage = cIContext.createCGImage(
                cIImage,
                from:cameraRect)
            
        else
        {
            return
        }
        
        background.texture = textureLoader.loadCGImage(cGImage:cGImage)
    }
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        renderEncoder.projectionMatrix(
            projection:projection.projectionBuffer)
        
        background.render(renderEncoder:renderEncoder)
        algo.render(renderEncoder:renderEncoder)
    }
}
