import UIKit
import CoreLocation

class CGrid:CController, CLLocationManagerDelegate
{
    let model:MGrid
    let modelAlgo:MGridAlgo
    private weak var viewGrid:VGrid!
    private(set) var userLocation:CLLocation?
    private var locationManager:CLLocationManager?
    
    override init()
    {
        model = MGrid()
        modelAlgo = MGridAlgo()
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewGrid:VGrid = VGrid(controller:self)
        self.viewGrid = viewGrid
        view = viewGrid
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        viewGrid.startLoading()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.loadAlgo()
        }
    }
    
    //MARK: private
    
    private func loadAlgo()
    {
        modelAlgo.loadAlgo(controller:self)
    }
    
    //MARK: public
    
    func algosLoaded()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewGrid.refresh()
        }
    }
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func openMap()
    {
        let controllerMap:CGridMap = CGridMap(modelAlgo:modelAlgo)
        parentController.push(
            controller:controllerMap,
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func openVisor()
    {
        let controllerVisor:CGridVisor = CGridVisor(modelAlgo:modelAlgo)
        parentController.push(
            controller:controllerVisor,
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
