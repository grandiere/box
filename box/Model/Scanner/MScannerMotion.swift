import Foundation
import CoreMotion

class MScannerMotion
{
    private enum MotionOrientation
    {
        case portrait
        case landscapeRight
        case landscapeLeft
    }
    
    private weak var controller:CScanner!
    private var motionOrientation:MotionOrientation
    private let manager:CMMotionManager!
    private let kRotationThreshold:Double = 2.7
    private let k180Deg:Float = 180
    private let kUpdatesInterval:TimeInterval = 0.07
    
    init(controller:CScanner)
    {
        self.controller = controller
        motionOrientation = MotionOrientation.portrait
        
        let manager:CMMotionManager = CMMotionManager()
        manager.deviceMotionUpdateInterval = kUpdatesInterval
        self.manager = manager
        
        if manager.isDeviceMotionAvailable
        {
            manager.startDeviceMotionUpdates(
                using:CMAttitudeReferenceFrame.xArbitraryZVertical,
                to:OperationQueue())
            { (data:CMDeviceMotion?, error:Error?) in
                
                guard
                    
                    let dataMotion:CMDeviceMotion = data
                    
                else
                {
                    return
                }
                
                let acceleration:CMAcceleration = dataMotion.gravity
                
                DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
                { [weak self] in
                    
                    self?.gravityCompute(acceleration:acceleration)
                }
            }
        }
    }
    
    //MARK: private
    
    private func orientationPortrait()
    {
        if motionOrientation != MotionOrientation.portrait
        {
            motionOrientation = MotionOrientation.portrait
            controller.modelGPS?.changeOrientationPortrait()
        }
    }
    
    private func orientationLandscapeLeft()
    {
        if motionOrientation != MotionOrientation.landscapeLeft
        {
            motionOrientation = MotionOrientation.landscapeLeft
            controller.modelGPS?.changeOrientationLandscapeLeft()
        }
    }
    
    private func orientationLandscapeRight()
    {
        if motionOrientation != MotionOrientation.landscapeRight
        {
            motionOrientation = MotionOrientation.landscapeRight
            controller.modelGPS?.changeOrientationLandscapeRight()
        }
    }
    
    private func gravityCompute(acceleration:CMAcceleration)
    {
        let accelerationX:Double = acceleration.x
        let accelerationY:Double = acceleration.y
        let accelerationZ:Double = acceleration.z
        let rawRotation:Double = atan2(accelerationX, accelerationY)
        
        let rawOther:Double = atan2(accelerationZ, accelerationY)
        let zRotation:Double = rawOther * 180.0 / Double.pi
        
        let rotationInversed:Double = rawRotation - Double.pi
        let rotationFloat:Float = Float(rotationInversed)
        let zRotationFloat:Float = Float(zRotation)
        let normalizedZRotation:Float
        
        if zRotationFloat >= 0
        {
            normalizedZRotation = -(k180Deg - zRotationFloat)
        }
        else
        {
            normalizedZRotation = k180Deg + zRotationFloat
        }
        
        if rawRotation >= 0
        {
            if rawRotation < kRotationThreshold
            {
                orientationLandscapeRight()
            }
            else
            {
                orientationPortrait()
            }
        }
        else
        {
            if rawRotation > -kRotationThreshold
            {
                orientationLandscapeLeft()
            }
            else
            {
                orientationPortrait()
            }
        }
        
        
//        controller.modelRender?.mines.motionRotate(
//            rawRotation:rawRotation,
//            xRotation:rotationFloat,
//            zRotation:normalizedZRotation)
    }
}
