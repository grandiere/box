import Foundation
import MetalKit
import ImageIO
import CoreLocation

class MScannerRender:MetalRenderableProtocol
{
    let camera:MScannerRenderBackground
    private weak var controller:CScanner!
    private let cIContext:CIContext
    private let textureLoader:MTKTextureLoader
    private let projection:MetalProjection
    
    init(
        controller:CScanner,
        device:MTLDevice)
    {
        self.controller = controller
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
        
        let defaultLocation:CLLocation = CLLocation(
            latitude:19.410595057002922,
            longitude:-99.175156495306979)
        let defaultMine:MScannerMinesItem = MScannerMinesItem(
            device:device,
            location:defaultLocation,
            texture:textureMenuBase)
        
        controller.modelMines.addItem(mine:defaultMine)
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
        
        
    }
}
