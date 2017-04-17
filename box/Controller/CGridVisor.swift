import UIKit
import CoreLocation
import MetalKit

class CGridVisor:CController
{
    var orientation:MScannerOrientation?
    private(set) weak var modelAlgo:MGridAlgo!
    private(set) var modelRender:MScannerRender?
    private(set) var modelCamera:MScannerCamera?
    private(set) var modelMotion:MScannerMotion?
    private(set) var modelGPS:MGridVisorGPS?
    private(set) weak var viewGridVisor:VGridVisor!
    
    init(modelAlgo:MGridAlgo)
    {
        self.modelAlgo = modelAlgo
        orientation = MScannerOrientationPortrait()
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        cleanSession()
    }
    
    override var prefersStatusBarHidden:Bool
    {
        return true
    }
    
    override func loadView()
    {
        let viewGridVisor:VGridVisor = VGridVisor(controller:self)
        self.viewGridVisor = viewGridVisor
        view = viewGridVisor
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        parentController.viewParent.panRecognizer.isEnabled = false
        
        guard
            
            let device:MTLDevice = viewGridVisor.viewMetal?.device
            
        else
        {
            return
        }
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.turnOnGPS()
        }
        /*
        if modelRender == nil
        {
            modelRender = MScannerRender(
                controller:self,
                device:device)
        }
        
        if modelCamera == nil
        {
            modelCamera = MScannerCamera(controller:self)
        }
        
        if modelMotion == nil
        {
            modelMotion = MScannerMotion(controller:self)
        }
        
        if modelGPS == nil
        {
            modelGPS = MScannerGPS(controller:self)
        }*/
    }
    
    //MARK: private
    
    private func cleanSession()
    {
        modelCamera?.cleanSession()
    }
    
    private func turnOnGPS()
    {
        if modelGPS == nil
        {
            modelGPS = MGridVisorGPS(controller:self)
        }
    }
    
    //MARK: public
    
    func back()
    {
        cleanSession()
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func locationFound(currentLocation:CLLocation)
    {
        
    }
}
