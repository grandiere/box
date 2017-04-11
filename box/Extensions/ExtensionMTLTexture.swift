import UIKit
import MetalKit

extension MTLTexture
{
    func exportImage() -> UIImage?
    {
        let image:UIImage?
        let byteCount:Int = width * height * 4
        
        guard
            
            let bytes:UnsafeMutableRawPointer = malloc(byteCount)
            
        else
        {
            return nil
        }
        
        let bytesPerRow:Int = width * 4
        let region:MTLRegion = MTLRegionMake2D(0, 0, width, height)
        getBytes(bytes, bytesPerRow:bytesPerRow, from:region, mipmapLevel:0)
        
        guard
            
            let dataProvider:CGDataProvider = CGDataProvider(
                dataInfo:nil,
                data:bytes,
                size:byteCount,
                releaseData:
                { (info, data, size) in
            })
            
        else
        {
            return nil
        }
        
        let bitsPerComponent:Int = 8
        let bitsPerPixel:Int = 32
        let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitMapInfo:CGBitmapInfo = CGBitmapInfo([
            CGBitmapInfo.byteOrder32Little,
            CGBitmapInfo(rawValue:CGImageAlphaInfo.noneSkipFirst.rawValue)
            ])
        let renderingIntent:CGColorRenderingIntent = CGColorRenderingIntent.defaultIntent
        
        guard
            
            let cgImage:CGImage = CGImage(
                width:width,
                height:height,
                bitsPerComponent:bitsPerComponent,
                bitsPerPixel:bitsPerPixel,
                bytesPerRow:bytesPerRow,
                space:colorSpace,
                bitmapInfo:bitMapInfo,
                provider:dataProvider,
                decode:nil,
                shouldInterpolate:false,
                intent:renderingIntent)
            
        else
        {
            return nil
        }
        
        image = UIImage(
            cgImage:cgImage,
            scale:0.0,
            orientation:UIImageOrientation.up)
        
        return image
    }
}
