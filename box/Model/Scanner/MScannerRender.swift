import Foundation
import MetalKit
import ImageIO

class MScannerRender:MetalRenderableProtocol
{
    let camera:MScannerRenderBackground
    var book:MScannerRenderBook?
    private let cIContext:CIContext
    private let textureLoader:MTKTextureLoader
    private let projection:MetalProjection
    
    init(device:MTLDevice)
    {
        cIContext = CIContext(mtlDevice:device)
        textureLoader = MTKTextureLoader(device:device)
        camera = MScannerRenderBackground(device:device)
        projection = MetalProjection(device:device)
        
        guard
            
            let textureMenuBase:MTLTexture = textureLoader.loadImage(
                image:#imageLiteral(resourceName: "assetTextureTriangle"))
            
        else
        {
            return
        }
        
        book = MScannerRenderBook(
            device:device,
            texture:textureMenuBase)
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
        
        camera.texture = textureLoader.loadCGImage(cGImage:cGImage)
    }
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        renderEncoder.projectionMatrix(
            projection:projection.projectionBuffer)
        
        camera.render(renderEncoder:renderEncoder)
        book?.render(renderEncoder:renderEncoder)
    }
}
