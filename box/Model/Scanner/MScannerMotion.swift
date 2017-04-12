import Foundation
import CoreMotion

class MScannerMotion
{
    private weak var controller:CScanner!
    private let manager:CMMotionManager!
    private let kUpdatesInterval:TimeInterval = 0.1
    
    init(controller:CScanner)
    {
        self.controller = controller
        
        let manager:CMMotionManager = CMMotionManager()
        self.manager = manager
        
        if manager.isDeviceMotionAvailable
        {
            manager.deviceMotionUpdateInterval = kUpdatesInterval
            manager.startDeviceMotionUpdates(
                to:OperationQueue.main)
            { (data:CMDeviceMotion?, error:Error?) in
                
                if error == nil
                {
                    guard
                        
                        let acceleration:CMAcceleration = data?.gravity
                        
                    else
                    {
                        return
                    }
                    
                    DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
                    { [weak self] in
                        
                        self?.gravityCompute(acceleration:acceleration)
                    }
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
        print(rawOther * 180.0 / Double.pi)
        
        controller.modelRender?.mines.motionRotate(rawRotation:rawRotation)
    }
}
