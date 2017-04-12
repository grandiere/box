import Foundation
import CoreMotion

class MScannerMotion
{
    private weak var controller:CScanner!
    private let manager:CMMotionManager!
    private let kUpdatesInterval:TimeInterval = 0.1
    private let kThresholdMines:Double = 0.9
    
    init(controller:CScanner)
    {
        self.controller = controller
        
        let manager:CMMotionManager = CMMotionManager()
        let renderMinesMinVal:Double = kThresholdMines
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
                let rawRotation:Double = atan2(accelerationX, accelerationY)
                let minesThreshold:Double = abs(accelerationY)
                let renderMines:Bool = minesThreshold > renderMinesMinVal
                
                let rawOther:Double = acos(accelerationX) * asin(accelerationY)
                print(rawOther)
                
                self?.controller.modelRender?.mines.motionRotate(rawRotation:rawRotation)
                self?.controller.modelRender?.shouldRenderMines = renderMines
            }
        }
    }
}
