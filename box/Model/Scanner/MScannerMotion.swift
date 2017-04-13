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
    private let k180Deg:Double = 180
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
        
        let rotationHorizontal:Double = atan2(accelerationX, accelerationY)
        let rotationHorizontalInversed:Double = rotationHorizontal - Double.pi
        let moveHorizontal:Float = Float(rotationHorizontalInversed)
        
        let rotationVertical:Double = atan2(accelerationZ, accelerationY)
        let rotationVerticalDeg:Double = rotationVertical * k180Deg / Double.pi
        let normalRotationVertical:Double
        
        if rotationVerticalDeg >= 0
        {
            normalRotationVertical = -(k180Deg - rotationVerticalDeg)
        }
        else
        {
            normalRotationVertical = k180Deg + rotationVerticalDeg
        }
        
        let moveVertical:Float = Float(normalRotationVertical)
        
        if rotationHorizontal >= 0
        {
            if rotationHorizontal < kRotationThreshold
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
            if rotationHorizontal > -kRotationThreshold
            {
                orientationLandscapeLeft()
            }
            else
            {
                orientationPortrait()
            }
        }
        
        print(180 - (rawRotation * 180 / Double.pi))
        
        let inverseHeading:Float = xRotation * 180.0 / Float.pi
        
        controller.modelRender?.mines.motionRotate(
            xRotation:xRotation,
            zRotation:normalizedZRotation,
            inverseHeading:inverseHeading)
    }
}
