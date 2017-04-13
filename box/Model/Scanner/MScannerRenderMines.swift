import Foundation
import CoreLocation
import MetalKit

class MScannerRenderMines:MetalRenderableProtocol
{
    var userHeading:Float
    private(set) var items:[MScannerRenderMinesItem]
    private var rotation:MetalRotation
    private var moveVertical:Float
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
        moveVertical = 0
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
        moveHorizontal:Float,
        moveVertical:Float)
    {
        self.moveVertical = moveVertical
        rotation = MetalRotation(radians:moveHorizontal)
    }
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        let rotationBuffer:MTLBuffer = renderEncoder.device.generateBuffer(
            bufferable:rotation)
        
        for item:MScannerRenderMinesItem in items
        {
            let itemPosition:MTLBuffer = item.positionBuffer(
                device:device,
                userHeading:userHeading,
                verticalAlign:moveVertical)
            
            renderEncoder.render(
                vertex:spatialSquare.vertexBuffer,
                position:itemPosition,
                rotation:rotationBuffer,
                texture:texture)
        }
    }
}
