import UIKit
import CoreLocation
import MetalKit

class CGridVisor:CController
{
    var orientation:MGridVisorOrientation?
    weak var targeting:MGridAlgoItem?
    private(set) weak var modelAlgo:MGridAlgo!
    private(set) var modelRender:MGridVisorRender?
    private(set) var modelCamera:MGridVisorCamera?
    private(set) var modelMotion:MGridVisorMotion?
    private(set) var modelGPS:MGridVisorGPS?
    private(set) weak var viewGridVisor:VGridVisor!
    
    init(modelAlgo:MGridAlgo)
    {
        self.modelAlgo = modelAlgo
        orientation = MGridVisorOrientationPortrait()
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
        viewGridVisor.viewBar.viewEnergy.refresh()
        viewGridVisor.viewMenu.isHidden = false
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.turnOnGPS()
        }
    }
    
    override func viewWillDisappear(_ animated:Bool)
    {
        super.viewWillDisappear(animated)
        viewGridVisor.viewMenu.isHidden = true
    }
    
    //MARK: private
    
    private func cleanSession()
    {
        modelCamera?.cleanSession()
        modelMotion?.cleanSession()
    }
    
    private func turnOnGPS()
    {
        if modelGPS == nil
        {
            modelGPS = MGridVisorGPS(controller:self)
        }
    }
    
    private func itemsFiltered()
    {
        viewGridVisor.showMetal()
        
        if modelMotion == nil
        {
            modelMotion = MGridVisorMotion(controller:self)
        }
        
        if modelCamera == nil
        {
            modelCamera = MGridVisorCamera(controller:self)
        }
        
        startRenders()
    }
    
    private func startRenders()
    {
        guard
            
            let device:MTLDevice = viewGridVisor.viewMetal?.device
            
        else
        {
            return
        }
        
        if modelRender == nil
        {
            modelRender = MGridVisorRender(
                controller:self,
                device:device)
            
            guard
                
                let algoList:[MGridAlgoItem] = modelAlgo.nearItems
                
            else
            {
                return
            }
            
            modelRender?.algo.renderAlgoList(nearItems:algoList)
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
        modelAlgo.filterNearItems(userLocation:currentLocation)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.itemsFiltered()
        }
    }
    
    func showAlgoDetail(item:MGridAlgoItem)
    {
        let controllerDetail:CGridVisorDetail = CGridVisorDetail(model:item)
        parentController.push(
            controller:controllerDetail,
            vertical:CParent.TransitionVertical.fromBottom,
            background:false)
    }
    
    func showAlgoMatch(item:MGridAlgoHostileItem)
    {
        let controllerMatch:CGridVisorMatch = CGridVisorMatch(model:item)
        parentController.animateOver(controller:controllerMatch)
    }
}
