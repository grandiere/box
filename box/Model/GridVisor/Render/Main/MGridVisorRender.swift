import Foundation
import MetalKit
import ImageIO
import CoreLocation

class MGridVisorRender:MetalRenderableProtocol
{
    let background:MGridVisorRenderBackground
    let algo:MGridVisorRenderAlgo
    private(set) weak var controller:CGridVisor!
    private(set) var rotationBuffer:MTLBuffer?
    private var rotation:MetalRotation
    private let finder:MGridVisorRenderFinder
    private let cIContext:CIContext
    private let textureLoader:MTKTextureLoader
    private let projection:MetalProjection
    private let textures:MGridVisorRenderTextures
    private let vertexes:MGridVisorRenderVertexes
    
    init(
        controller:CGridVisor,
        device:MTLDevice)
    {
        textureLoader = MTKTextureLoader(device:device)
        textures = MGridVisorRenderTextures(textureLoader:textureLoader)
        vertexes = MGridVisorRenderVertexes(device:device)
        
        cIContext = CIContext(mtlDevice:device)
        background = MGridVisorRenderBackground(device:device)
        projection = MetalProjection(device:device)
        rotation = MetalRotation.none()
        
        algo = MGridVisorRenderAlgo(
            device:device,
            textureLoader:textureLoader)
        
        finder = MGridVisorRenderFinder(
            device:device,
            textureLoader:textureLoader)
        
        algo.render = self
        finder.render = self
        self.controller = controller
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
    
    func motionRotate(
        moveHorizontal:Float,
        moveVertical:Float)
    {
        algo.moveVertical = moveVertical
        rotation = MetalRotation(radians:moveHorizontal)
    }
    
    //MARK: renderable Protocol
    
    func render(manager:MetalRenderManager)
    {
        manager.projectionMatrix(
            projection:projection.projectionBuffer)
        
        rotationBuffer = manager.device.generateBuffer(
            bufferable:rotation)
        
        background.render(manager:manager)
        algo.render(manager:manager)
        finder.render(manager:manager)
    }
}
