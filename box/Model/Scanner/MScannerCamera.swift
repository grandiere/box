import UIKit
import AVFoundation
import ImageIO

class MScannerCamera:NSObject, AVCaptureVideoDataOutputSampleBufferDelegate
{
    private var captureSession:AVCaptureSession?
    private weak var controller:CScanner!
    private weak var videoDataOutput:AVCaptureVideoDataOutput?
    private weak var captureDeviceInput:AVCaptureDeviceInput?
    private let queueCamera:DispatchQueue
    private let queueOutput:DispatchQueue
    private let kDevicePosition:AVCaptureDevicePosition = AVCaptureDevicePosition.back
    private let kMediaType:String = AVMediaTypeVideo
    private let kSessionPreset:String = AVCaptureSessionPreset640x480
    private let kVideoGravity:String = AVLayerVideoGravityResizeAspect
    private let kVideoCodec:String = AVVideoCodecJPEG
    private let kQueueCameraLabel:String = "scannerCameraQueue"
    private let kQueueOutputLabel:String = "scannerOutputQueue"
    private let kImageOrientationUp:Int32 = 6
    
    init(controller:CScanner)
    {
        self.controller = controller
        
        queueCamera = DispatchQueue(
            label:kQueueCameraLabel,
            qos:DispatchQoS.background,
            attributes:DispatchQueue.Attributes(),
            autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
            target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        
        queueOutput = DispatchQueue(
            label:kQueueOutputLabel,
            qos:DispatchQoS.background,
            attributes:DispatchQueue.Attributes(),
            autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
            target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        
        super.init()
        
        askAuthorization()
    }
    
    deinit
    {
        cleanSession()
    }
    
    //MARK: private
    
    private func askAuthorization()
    {
        AVCaptureDevice.requestAccess(forMediaType:kMediaType)
        { [weak self] (granted:Bool) in
            
            if granted
            {
                self?.queueCamera.async
                { [weak self] in
                    
                    self?.startSession()
                }
            }
            else
            {
                let error:String = NSLocalizedString("MScannerCamera_errorNoAuth", comment:"")
                VAlert.message(message:error)
            }
        }
    }
    
    private func startSession()
    {
        let captureSession:AVCaptureSession = AVCaptureSession()
        captureSession.sessionPreset = kSessionPreset
        self.captureSession = captureSession
        
        var captureDevice:AVCaptureDevice?
        
        if #available(iOS 10.0, *)
        {
            captureDevice = AVCaptureDevice.defaultDevice(
                withDeviceType:AVCaptureDeviceType.builtInWideAngleCamera,
                mediaType:kMediaType,
                position:kDevicePosition)
        }
        else
        {
            let devices:[Any] = AVCaptureDevice.devices(
                withMediaType:kMediaType)
            
            for device:Any in devices
            {
                guard
                    
                    let capture:AVCaptureDevice = device as? AVCaptureDevice
                    
                else
                {
                    continue
                }
                
                if capture.position == kDevicePosition
                {
                    captureDevice = capture
                    
                    break
                }
            }
        }
        
        guard
            
            let foundCaptureDevice:AVCaptureDevice = captureDevice
            
        else
        {
            let error:String = NSLocalizedString("MScannerCamera_errorNoCaptureDevice", comment:"")
            VAlert.message(message:error)
            
            return
        }
        
        let captureDeviceInput:AVCaptureDeviceInput
        
        do
        {
            try captureDeviceInput = AVCaptureDeviceInput(
                device:foundCaptureDevice)
        }
        catch let error
        {
            print(error.localizedDescription)
            
            return
        }
        
        self.captureDeviceInput = captureDeviceInput
        captureSession.addInput(captureDeviceInput)
        
        let videoDataOutput:AVCaptureVideoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.videoSettings = [String(kCVPixelBufferPixelFormatTypeKey) : Int(kCVPixelFormatType_32BGRA) as NSNumber]
        videoDataOutput.setSampleBufferDelegate(
            self,
            queue:queueOutput)
        self.videoDataOutput = videoDataOutput
        
        if captureSession.canAddOutput(videoDataOutput)
        {
            captureSession.addOutput(videoDataOutput)
            captureSession.startRunning()
        }
        else
        {
            let error:String = NSLocalizedString("MScannerCamera_errorNoOutput", comment:"")
            VAlert.message(message:error)
        }
    }
    
    //MARK: public
    
    func cleanSession()
    {
        captureSession?.stopRunning()
        captureSession?.removeInput(captureDeviceInput)
        captureSession?.removeOutput(videoDataOutput)
    }
    
    //MARK: captureOutput delegate
    
    func captureOutput(_ captureOutput:AVCaptureOutput!, didOutputSampleBuffer sampleBuffer:CMSampleBuffer!, from connection:AVCaptureConnection!)
    {
        guard
            
            let pixelBuffer:CVImageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
            
        else
        {
            return
        }
        
        let ciimage:CIImage = CIImage(cvImageBuffer:pixelBuffer)
        let imageOriented:CIImage = ciimage.applyingOrientation(kImageOrientationUp)
        controller.modelRender?.updateCameraImage(cIImage:imageOriented)
    }
}
