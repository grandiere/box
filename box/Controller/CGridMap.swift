import UIKit
import CoreLocation

class CGridMap:CController
{
    private(set) weak var modelAlgo:MGridAlgo!
    private weak var viewMap:VGridMap!
    private var locationAsked:Bool
    private let kDistanceFilter:CLLocationDistance = 10
    private let kDistanceAccuracy:CLLocationDistance = 100
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
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.distanceFilter = kDistanceFilter
            self.locationManager = locationManager
            
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
