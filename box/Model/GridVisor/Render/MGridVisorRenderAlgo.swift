import Foundation
import CoreLocation
import MetalKit

class MGridVisorRenderAlgo:MetalRenderableProtocol
{
    var userHeading:Float
    private weak var textureLoader:MTKTextureLoader?
    private weak var controller:CGridVisor!
    private weak var device:MTLDevice!
    private(set) var items:[MGridVisorRenderAlgoItem]
    private var rotation:MetalRotation
    private var moveVertical:Float
    private let spatialSquare:MetalSpatialShapeSquarePositive
    
    init(
        controller:CGridVisor,
        device:MTLDevice,
        textureLoader:MTKTextureLoader)
    {
        self.controller = controller
        self.device = device
        self.textureLoader = textureLoader
        rotation = MetalRotation.none()
        moveVertical = 0
        userHeading = 0
        items = []
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
    
    func addAlgo(nearItems:[MGridAlgoItem])
    {
        
    }
    
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
