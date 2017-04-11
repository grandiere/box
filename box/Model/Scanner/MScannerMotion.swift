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
            { [weak self] (data:CMDeviceMotion?, error:Error?) in
                
                if let error:Error = error
                {
                    print(error.localizedDescription)
                    
                    return
                }
                
                guard
                    
                    let acceleration:CMAcceleration = data?.gravity
                    
                else
                {
                    return
                }
                
                let accelerationX:Double = acceleration.x
                let accelerationY:Double = acceleration.y
                let accelerationZ:Double = acceleration.z
                
                let rotation:Double = atan2(accelerationX, accelerationY) - Double.pi
                let rotationFloat:Float = Float(rotation)
                self?.controller.modelRender?.book?.motionRotate(radians:rotationFloat)
                
                print("accz \(accelerationZ)")
            }
        }
    }
}
