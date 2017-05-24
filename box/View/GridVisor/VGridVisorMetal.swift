import UIKit
import MetalKit

class VGridVisorMetal:MTKView
{
    private weak var controller:CGridVisor?
    private let samplerState:MTLSamplerState
    private let commandQueue:MTLCommandQueue
    private let simplePipelineState:MTLRenderPipelineState
    private let colourPipelineState:MTLRenderPipelineState
    
    init?(controller:CGridVisor)
    {
        guard
            
            let device:MTLDevice = MTLCreateSystemDefaultDevice(),
            let library:MTLLibrary = device.newDefaultLibrary(),
            let vertexFunction:MTLFunction = library.makeFunction(
                name:MetalConstants.kVertexFunction),
            let simpleFragmentFunction:MTLFunction = library.makeFunction(
                name:MetalConstants.kFragmentFunctionSimple),
            let colourFragmentFunction:MTLFunction = library.makeFunction(
                name:MetalConstants.kFragmentFunctionColour)
            
        else
        {
            return nil
        }
        
        commandQueue = device.makeCommandQueue()
        
        let sampleDescriptor = MTLSamplerDescriptor()
        sampleDescriptor.minFilter = MetalConstants.kSamplerMinFilter
        sampleDescriptor.magFilter = MetalConstants.kSamplerMagFilter
        sampleDescriptor.mipFilter = MetalConstants.kSamplerMipFilter
        sampleDescriptor.sAddressMode = MetalConstants.kSamplerSAddressMode
        sampleDescriptor.tAddressMode = MetalConstants.kSamplerTAddressMode
        sampleDescriptor.rAddressMode = MetalConstants.kSamplerRAddressMode
        sampleDescriptor.lodMinClamp = MetalConstants.kSamplerLodMinClamp
        sampleDescriptor.lodMaxClamp = MetalConstants.kSamplerLodMaxClamp
        sampleDescriptor.maxAnisotropy = MetalConstants.kSamplerMaxAnisotropy
        sampleDescriptor.normalizedCoordinates = MetalConstants.kSamplerNormalizedCoordinates
        samplerState = device.makeSamplerState(descriptor:sampleDescriptor)
        
        let simplePipelineDescriptor:MTLRenderPipelineDescriptor = MTLRenderPipelineDescriptor()
        simplePipelineDescriptor.vertexFunction = vertexFunction
        simplePipelineDescriptor.fragmentFunction = simpleFragmentFunction
        
        let colourPipelineDescriptor:MTLRenderPipelineDescriptor = MTLRenderPipelineDescriptor()
        colourPipelineDescriptor.vertexFunction = vertexFunction
        colourPipelineDescriptor.fragmentFunction = colourFragmentFunction
        
        do
        {
            try simplePipelineState = device.makeRenderPipelineState(
                descriptor:simplePipelineDescriptor)
        }
        catch
        {
            return nil
        }
        
        do
        {
            try colourPipelineState = device.makeRenderPipelineState(
                descriptor:colourPipelineDescriptor)
        }
        catch
        {
            return nil
        }
        
        super.init(frame:CGRect.zero, device:device)
        backgroundColor = UIColor.clear
        framebufferOnly = true
        clipsToBounds = true
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = UIViewContentMode.center
        autoResizeDrawable = true
        isPaused = false
        self.controller = controller
        
        let colorAttachmentSimple:MTLRenderPipelineColorAttachmentDescriptor = simplePipelineDescriptor.colorAttachments[
            MetalConstants.kColorAttachmentIndex]
        let colorAttachmentColour:MTLRenderPipelineColorAttachmentDescriptor = simplePipelineDescriptor.colorAttachments[
            MetalConstants.kColorAttachmentIndex]
        
        colorAttachmentConfig(colorAttachment:colorAttachmentSimple)
        colorAttachmentConfig(colorAttachment:colorAttachmentColour)
    }
    
    required init(coder:NSCoder)
    {
        fatalError()
    }
    
    override func draw()
    {
        super.draw()
        
        guard
            
            let controller:CGridVisor = self.controller
        
        else
        {
            return
        }
        
        guard
        
            let drawable:CAMetalDrawable = currentDrawable,
            let passDescriptor:MTLRenderPassDescriptor = currentRenderPassDescriptor
            
        else
        {
            return
        }
        
        let commandBuffer:MTLCommandBuffer = commandQueue.makeCommandBuffer()
        let renderEncoder:MTLRenderCommandEncoder = commandBuffer.makeRenderCommandEncoder(
            descriptor:passDescriptor)
        renderEncoder.setCullMode(MTLCullMode.none)
        renderEncoder.setFragmentSamplerState(
            samplerState,
            at:MetalConstants.kFragmentSamplerIndex)
        controller.modelRender?.render(renderEncoder:renderEncoder)
        
        renderEncoder.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
    
    //MARK: private
    
    private func colorAttachmentConfig(colorAttachment:MTLRenderPipelineColorAttachmentDescriptor)
    {
        colorAttachment.pixelFormat = MetalConstants.kPixelFormat
        colorAttachment.isBlendingEnabled = MetalConstants.kBlendingEnabled
        colorAttachment.rgbBlendOperation = MetalConstants.kRgbBlendOperation
        colorAttachment.alphaBlendOperation = MetalConstants.kAlphaBlendOperation
        colorAttachment.sourceRGBBlendFactor = MetalConstants.kSourceRgbBlendFactor
        colorAttachment.sourceAlphaBlendFactor = MetalConstants.kSourceAlphaBlendFactor
        colorAttachment.destinationRGBBlendFactor = MetalConstants.kDestinationRgbBlendFactor
        colorAttachment.destinationAlphaBlendFactor = MetalConstants.kDestinationAlphaBlendFactor
    }
}
