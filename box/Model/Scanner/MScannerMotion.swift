import Foundation
import CoreMotion

class MScannerMotion
{
    private weak var controller:CScanner!
    private let manager:CMMotionManager!
    private let kUpdatesInterval:TimeInterval = 0.09
    
    init(controller:CScanner)
    {
        self.controller = controller
        
        let manager:CMMotionManager = CMMotionManager()
        manager.deviceMotionUpdateInterval = kUpdatesInterval
        self.manager = manager
        
        if manager.isDeviceMotionAvailable
        {
            manager.startDeviceMotionUpdates(
                using:CMAttitudeReferenceFrame.xTrueNorthZVertical,
                to:OperationQueue.main)
            { (data:CMDeviceMotion?, error:Error?) in
                
                if error == nil
                {
                    guard
                        
                        let dataMotion:CMDeviceMotion = data
                        
                    else
                    {
                        return
                    }
                    
                    let acceleration:CMAcceleration = dataMotion.gravity
                    let attitude:CMAttitude = dataMotion.attitude
                    let rotation:CMRotationMatrix = attitude.rotationMatrix
                    let quaternion:CMQuaternion = attitude.quaternion
                    self.gravityCompute(acceleration:acceleration)
                    
                    //                        print((attitude.yaw + (Double.pi / 2)) * -180.0 / Double.pi)
                    
                    //let heading = Double.atan2(rotation.m22, rotation.m12)
                    
                    let heading = atan2(quaternion.z, quaternion.x)
                    //let heading = (quaternion.z + ((quaternion.x/2) + (quaternion.y))) * Double.pi
                    let headingDegrees = heading * 180.0 / Double.pi
                    
                    controller.modelRender?.mines.userHeading = -headingDegrees
                    
                    print("\(quaternion.x) : \(quaternion.y) : \(quaternion.z)")
                }
            }
        }
    }
    
    //MARK: private
    
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
            normalizedZRotation = -(180 - zRotationFloat)
        }
        else
        {
            normalizedZRotation = 180 + zRotationFloat
        }
        
        controller.modelRender?.mines.motionRotate(
            rawRotation:rawRotation,
            xRotation:rotationFloat,
            zRotation:normalizedZRotation)
    }
}
