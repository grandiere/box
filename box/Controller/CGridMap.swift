import UIKit
import CoreLocation

class CGridMap:CController
{
    private(set) weak var modelAlgo:MGridAlgo!
    private(set) weak var viewMap:VGridMap!
    private(set) var modelMap:MGridMap?
    private var locationAsked:Bool
    private let kDistanceFilter:CLLocationDistance = 100
    private var locationManager:CLLocationManager?
    
    init(modelAlgo:MGridAlgo)
    {
        self.modelAlgo = modelAlgo
        locationAsked = false
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        locationManager = nil
    }
    
    override func loadView()
    {
        let viewMap:VGridMap = VGridMap(controller:self)
        self.viewMap = viewMap
        view = viewMap
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        parentController.viewParent.panRecognizer.isEnabled = false
        
        if !locationAsked
        {
            locationAsked = true
            askLocation()
        }
    }
    
    //MARK: private
    
    private func askLocation()
    {
        let status:CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        
        if status == CLAuthorizationStatus.notDetermined
        {
            let locationManager:CLLocationManager = CLLocationManager()
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.distanceFilter = kDistanceFilter
            self.locationManager = locationManager
            
            locationManager.requestWhenInUseAuthorization()
        }
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.loadModelMap()
        }
    }
    
    private func loadModelMap()
    {
        modelMap = MGridMap(modelAlgo:modelAlgo)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.modelMapLoaded()
        }
    }
    
    private func modelMapLoaded()
    {
        guard
            
            let annotations:[MGridMapAnnotation] = modelMap?.annotations
        
        else
        {
            return
        }
        
        viewMap.viewRender.addAnnotations(annotations)
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
