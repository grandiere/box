import MetalKit

extension MTLDevice
{
    func generateBuffer(bufferable:MetalBufferableProtocol) -> MTLBuffer
    {
        let data:[Float] = bufferable.buffer()
        let dataLength:Int = data.count
        let dataSize:Int = dataLength * MetalConstants.kBufferElementSize
        let buffer:MTLBuffer = makeBuffer(
            bytes:data,
            length:dataSize,
            options:MTLResourceOptions())
        
        return buffer
    }
}
