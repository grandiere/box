import UIKit
import CoreLocation

class CGrid:CController, CLLocationManagerDelegate
{
    let model:MGrid
    let modelAlgo:MGridAlgo
    private weak var viewGrid:VGrid!
    private(set) var userLocation:CLLocation?
    private var locationManager:CLLocationManager?
    private let kDistanceFilter:CLLocationDistance = 1000
    
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
    
    deinit
    {
        locationManager?.stopUpdatingLocation()
        locationManager = nil
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
            
            self?.loadModel()
        }
    }
    
    //MARK: private
    
    private func loadAlgo(userLocation:CLLocation)
    {
        modelAlgo.loadAlgo(
            userLocation:userLocation,
            controller:self)
    }
    
    private func loadModel()
    {
        if let userLocation:CLLocation = userLocation
        {
            loadAlgo(userLocation:userLocation)
        }
        else
        {
            DispatchQueue.main.async
            { [weak self] in
                
                self?.askLocation()
            }
        }
    }
    
    private func askLocation()
    {
        let locationManager:CLLocationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = kDistanceFilter
        locationManager.delegate = self
        self.locationManager = locationManager
        
        let status:CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        
        switch status
        {
        case CLAuthorizationStatus.notDetermined:
            
            locationManager.requestWhenInUseAuthorization()
            
            break
            
        case CLAuthorizationStatus.denied:
            
            locationDenied()
            
            break
            
        default:
            
            locationAuthorized()
            
            break
        }
    }
    
    private func locationDenied()
    {
        let error:String = NSLocalizedString("CGrid_noLocationGranted", comment:"")
        VAlert.messageOrange(message:error)
    }
    
    private func locationAuthorized()
    {
        locationManager?.startUpdatingLocation()
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
    
    func openVirus()
    {
        let controllerVirus:CGridVirus = CGridVirus(modelAlgo:modelAlgo)
        parentController.push(
            controller:controllerVirus,
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    //MARK: location delegate
    
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations:[CLLocation])
    {
        guard
            
            let userLocation:CLLocation = locations.last
            
        else
        {
            return
        }
        
        let horizontalAccuracy:CLLocationAccuracy = userLocation.horizontalAccuracy
        
        if horizontalAccuracy <= kDistanceFilter
        {
            self.userLocation = userLocation
            manager.stopUpdatingLocation()
            locationManager = nil
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.loadAlgo(userLocation:userLocation)
            }
        }
    }
    
    func locationManager(_ manager:CLLocationManager, didChangeAuthorization status:CLAuthorizationStatus)
    {
        switch status
        {
        case CLAuthorizationStatus.notDetermined:
            
            break
            
        case CLAuthorizationStatus.denied:
            
            locationDenied()
            
            break
            
        default:
            
            locationAuthorized()
            
            break
        }
    }
}
