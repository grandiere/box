import Foundation
import CoreLocation
import MetalKit

class MScannerRenderMines:MetalRenderableProtocol
{
    var userHeading:Float
    private weak var controller:CScanner!
    private(set) var items:[MScannerRenderMinesItem]
    private var rotation:MetalRotation
    private var moveVertical:Float
    private let device:MTLDevice
    private let texture:MTLTexture
    private let spatialSquare:MetalSpatialShapeSquarePositive
    private let kWidth:Float = 110
    private let kHeight:Float = 110
    private let kVerticalMultiplier:Float = 5
    private let kHorizontalMultiplier:Float = 10
    
    init(
        controller:CScanner,
        device:MTLDevice,
        texture:MTLTexture)
    {
        self.controller = controller
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
        
        let defaultHeading:Float = -90
        let defaultHeadingMultiplied:Float = defaultHeading * kHorizontalMultiplier
        
        let itemDefault:MScannerRenderMinesItem = MScannerRenderMinesItem(
            location:defaultLocation,
            mineHeading:defaultHeadingMultiplied)
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
        let headingMultiplied:Float = userHeading * kHorizontalMultiplier
        let verticalMultiplied:Float = moveVertical * kVerticalMultiplier
        
        for item:MScannerRenderMinesItem in items
        {
            let mineHeading:Float = item.mineHeading
            let positionX:Float
            let positionY:Float
            
            switch controller.orientation
            {
            case MScannerMotion.Orientation.portrait:
                
                positionX = mineHeading - headingMultiplied
                positionY = verticalMultiplied
                
                break
                
            case MScannerMotion.Orientation.landscapeRight:
                
                positionX = mineHeading - headingMultiplied
                positionY = verticalMultiplied
                
                break
                
            case MScannerMotion.Orientation.landscapeLeft:
                
                positionX = mineHeading - headingMultiplied
                positionY = verticalMultiplied
                
                break
            }
            
            let position:MetalPosition = MetalPosition(
                positionX:positionX,
                positionY:positionY)
            let positionBuffer:MTLBuffer = device.generateBuffer(
                bufferable:position)
            
            renderEncoder.render(
                vertex:spatialSquare.vertexBuffer,
                position:positionBuffer,
                rotation:rotationBuffer,
                texture:texture)
        }
    }
}
