import Foundation
import MetalKit

class MScannerRenderMines:MetalRenderableProtocol
{
    private(set) var items:[MScannerRenderMinesItem]
    private var rotation:MetalRotation
    private let texture:MTLTexture
    private let spatialSquare:MetalSpatialShapeSquarePositive
    private let kWidth:Float = 100
    private let kHeight:Float = 100
    
    init(
        device:MTLDevice,
        texture:MTLTexture)
    {
        self.texture = texture
        spatialSquare = MetalSpatialShapeSquarePositive(
            device:device,
            width:kWidth,
            height:kHeight)
        rotation = MetalRotation.none()
        items = []
    }
    
    //MARK: public
    
    func addItem(mine:MScannerMinesItem)
    {
        items.append(mine)
    }
    
    func motionRotate(radians:Float)
    {
        rotation = MetalRotation(radians:radians)
    }
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        let rotationBuffer:MTLBuffer = renderEncoder.device.generateBuffer(
            bufferable:rotation)
        
        for item:MScannerMinesItem in items
        {
            renderEncoder.render(
                vertex:spatialSquare.vertexBuffer,
                position:item.positionBuffer,
                rotation:rotationBuffer,
                texture:texture)
        }
    }
}
