import UIKit
import MetalKit

class CScanner:CController
{
    private(set) var modelRender:MScannerRender?
    private(set) var modelCamera:MScannerCamera?
    private(set) var modelMotion:MScannerMotion?
    private(set) var modelGPS:MScannerGPS?
    private(set) weak var viewScanner:VScanner!
    
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
        let viewScanner:VScanner = VScanner(controller:self)
        self.viewScanner = viewScanner
        view = viewScanner
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        guard
            
            let device:MTLDevice = viewScanner.viewMetal?.device
            
        else
        {
            return
        }
        
        if modelRender == nil
        {
            modelRender = MScannerRender(device:device)
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
        }
    }
    
    //MARK: private
    
    private func cleanSession()
    {
        modelCamera?.cleanSession()
    }
    
    //MARK: public
    
    func back()
    {
        cleanSession()
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
