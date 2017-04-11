import Foundation
import CoreLocation
import MetalKit

class MScannerRenderMines:MetalRenderableProtocol
{
    private(set) var items:[MScannerRenderMinesItem]
    private var rotation:MetalRotation
    private let device:MTLDevice
    private let texture:MTLTexture
    private let spatialSquare:MetalSpatialShapeSquarePositive
    private let kWidth:Float = 100
    private let kHeight:Float = 100
    
    init(
        device:MTLDevice,
        texture:MTLTexture)
    {
        self.device = device
        self.texture = texture
        spatialSquare = MetalSpatialShapeSquarePositive(
            device:device,
            width:kWidth,
            height:kHeight)
        rotation = MetalRotation.none()
        items = []
        
        let defaultLocation:CLLocation = CLLocation(
            latitude:19.410595057002922,
            longitude:-99.175156495306979)
        
        let itemDefault:MScannerRenderMinesItem = MScannerRenderMinesItem(
            location:defaultLocation)
        items.append(itemDefault)
    }
    
    //MARK: public
    
    func motionRotate(radians:Float)
    {
        rotation = MetalRotation(radians:radians)
    }
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        let rotationBuffer:MTLBuffer = renderEncoder.device.generateBuffer(
            bufferable:rotation)
        
        for item:MScannerRenderMinesItem in items
        {
            let itemPosition:MTLBuffer = item.positionBuffer(device:device)
            
            renderEncoder.render(
                vertex:spatialSquare.vertexBuffer,
                position:itemPosition,
                rotation:rotationBuffer,
                texture:texture)
        }
    }
}
