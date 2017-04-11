import Foundation
import CoreLocation
import MetalKit

class MScannerRenderMines:MetalRenderableProtocol
{
    var userHeading:Double
    private(set) var items:[MScannerRenderMinesItem]
    private var rotation:MetalRotation
    private var normalizedCompensation:Double
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
        userHeading = 0
        normalizedCompensation = 0
        items = []
        
        let defaultLocation:CLLocation = CLLocation(
            latitude:19.410595057002922,
            longitude:-99.175156495306979)
        
        let itemDefault:MScannerRenderMinesItem = MScannerRenderMinesItem(
            location:defaultLocation)
        items.append(itemDefault)
    }
    
    //MARK: public
    
    func motionRotate(rawRotation:Double)
    {
        let compensateRotation:Double = ((rawRotation * 180.0) / Double.pi)
        
        if compensateRotation >= 0
        {
            normalizedCompensation = -(180 - compensateRotation)
        }
        else
        {
            normalizedCompensation = -(-180 - compensateRotation)
        }
        
        let rotationInversed:Double = rawRotation - Double.pi
        let rotationFloat:Float = Float(rotationInversed)
        rotation = MetalRotation(radians:rotationFloat)
    }
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        let rotationBuffer:MTLBuffer = renderEncoder.device.generateBuffer(
            bufferable:rotation)
        let heading:Double = userHeading + normalizedCompensation
        
        for item:MScannerRenderMinesItem in items
        {
            let itemPosition:MTLBuffer = item.positionBuffer(
                device:device,
                heading:heading)
            
            renderEncoder.render(
                vertex:spatialSquare.vertexBuffer,
                position:itemPosition,
                rotation:rotationBuffer,
                texture:texture)
        }
    }
}
