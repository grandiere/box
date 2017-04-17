import Foundation
import MetalKit
import ImageIO
import CoreLocation

class MGridVisorRender:MetalRenderableProtocol
{
    let background:MScannerRenderBackground
    let algo:MGridVisorRenderAlgo
    let mines:MScannerRenderMines
    private let cIContext:CIContext
    private let textureLoader:MTKTextureLoader
    private let projection:MetalProjection
    
    init?(
        controller:CScanner,
        device:MTLDevice)
    {
        textureLoader = MTKTextureLoader(device:device)
        
        guard
            
            let textureMenuBase:MTLTexture = textureLoader.loadImage(
                image:#imageLiteral(resourceName: "assetTextureTriangle"))
            
        else
        {
            return nil
        }
        
        cIContext = CIContext(mtlDevice:device)
        background = MScannerRenderBackground(device:device)
        projection = MetalProjection(device:device)
        mines = MScannerRenderMines(
            controller:controller,
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
        
        background.texture = textureLoader.loadCGImage(cGImage:cGImage)
    }
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        renderEncoder.projectionMatrix(
            projection:projection.projectionBuffer)
        
        background.render(renderEncoder:renderEncoder)
        mines.render(renderEncoder:renderEncoder)
    }
}
