import Foundation
import CoreLocation
import MetalKit

class MScannerRenderMines:MetalRenderableProtocol
{
    var userHeading:Double
    private(set) var items:[MScannerRenderMinesItem]
    private(set) var inverseHeading:Float
    private var rotation:MetalRotation
    private var zRotation:Float
    private let device:MTLDevice
    private let texture:MTLTexture
    private let spatialSquare:MetalSpatialShapeSquarePositive
    private let kWidth:Float = 110
    private let kHeight:Float = 110
    
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
        inverseHeading = 0
        zRotation = 0
        userHeading = 0
        items = []
        
        let defaultLocation:CLLocation = CLLocation(
            latitude:19.410595057002922,
            longitude:-99.175156495306979)
        
        let itemDefault:MScannerRenderMinesItem = MScannerRenderMinesItem(
            location:defaultLocation)
        items.append(itemDefault)
    }
    
    //MARK: public
    
    func motionRotate(
        xRotation:Float,
        zRotation:Float,
        inverseHeading:Float)
    {
//        self.zRotation = zRotation
        self.inverseHeading = inverseHeading
        rotation = MetalRotation(radians:xRotation)
    }
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        let rotationBuffer:MTLBuffer = renderEncoder.device.generateBuffer(
            bufferable:rotation)
        let heading:Float = Float(userHeading)
        
        for item:MScannerRenderMinesItem in items
        {
            let itemPosition:MTLBuffer = item.positionBuffer(
                device:device,
                heading:heading,
                verticalAlign:zRotation)
            
            renderEncoder.render(
                vertex:spatialSquare.vertexBuffer,
                position:itemPosition,
                rotation:rotationBuffer,
                texture:texture)
        }
    }
}
