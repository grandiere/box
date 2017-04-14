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
        let headings:[Float] = [
            -180,
            -90,
            0,
            45,
            135
        ]
        
        for heading:Float in headings
        {
            addMine(
                location:defaultLocation,
                heading:heading)
        }
    }
    
    //MARK: private
    
    private func addMine(location:CLLocation, heading:Float)
    {
        guard
            
            let multipliedHeading:Float = controller.orientation?.normalHeading(
                rawHeading:heading)
        
        else
        {
            return
        }
        
        let item:MScannerRenderMinesItem = MScannerRenderMinesItem(
            location:location,
            mineHeading:multipliedHeading)
        items.append(item)
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
            let itemHeading:Float = item.mineHeading
            
            guard
                
                let position:MetalPosition = controller.orientation?.itemPosition(
                    userHeading:userHeading,
                    moveVertical:moveVertical,
                    itemHeading:itemHeading)
            
            else
            {
                continue
            }
            
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
