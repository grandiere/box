import Foundation
import CoreLocation

class MGridVisorGPS:NSObject, CLLocationManagerDelegate
{
    var compensateHeading:CLLocationDirection
    private var needsLocation:Bool
    private weak var controller:CGridVisor!
    private var locationManager:CLLocationManager?
    private let kDistanceFilter:CLLocationDistance = 10
    private let kDistanceAccuracy:CLLocationDistance = 100
    
    init(controller:CGridVisor)
    {
        self.controller = controller
        compensateHeading = 0
        needsLocation = true
        
        super.init()
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.asyncAskLocation()
        }
    }
    
    deinit
    {
        locationManager?.stopUpdatingHeading()
        locationManager?.stopUpdatingLocation()
    }
    
    //MARK: private
    
    private func asyncAskLocation()
    {
        let locationManager:CLLocationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = kDistanceFilter
        locationManager.delegate = self
        self.locationManager = locationManager
        
        let status:CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        
        switch status
        {
        case CLAuthorizationStatus.authorizedAlways,
             CLAuthorizationStatus.authorizedWhenInUse:
            
            authGranted()
            
            break
            
        case CLAuthorizationStatus.notDetermined:
            
            locationManager.requestWhenInUseAuthorization()
            
            break
            
        default:
            
            let error:String = NSLocalizedString("MGridVisorGPS_errorAuth", comment:"")
            VAlert.messageOrange(message:error)
            
            break
        }
    }
    
    private func authGranted()
    {
        locationManager?.startUpdatingLocation()
        locationManager?.startUpdatingHeading()
    }
    
    private func asyncMagneticHeading(magneticHeading:CLLocationDirection)
    {
        let normalHeading:CLLocationDirection
        
        if magneticHeading >= 180
        {
            normalHeading = magneticHeading - 360
        }
        else
        {
            normalHeading = magneticHeading
        }
        
        let finalHeading:CLLocationDirection = normalHeading - compensateHeading
        let finalHeadingFloat:Float = Float(finalHeading)
        controller.modelRender?.algo.userHeading = finalHeadingFloat
    }
    
    //MARK: location delegate
    
    func locationManager(_ manager:CLLocationManager, didChangeAuthorization status:CLAuthorizationStatus)
    {
        switch status
        {
        case CLAuthorizationStatus.authorizedAlways,
             CLAuthorizationStatus.authorizedWhenInUse:
            
            authGranted()
            
            break
            
        case CLAuthorizationStatus.notDetermined:
            break
            
        default:
            
            let error:String = NSLocalizedString("MGridVisorGPS_errorAuth", comment:"")
            VAlert.messageOrange(message:error)
            
            break
        }
    }
    
    func locationManager(_ manager:CLLocationManager, didFailWithError error:Error)
    {
    }
    
    func locationManager(_ manager:CLLocationManager, didUpdateHeading newHeading:CLHeading)
    {
        let magneticHeading:CLLocationDirection = newHeading.magneticHeading
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncMagneticHeading(magneticHeading:magneticHeading)
        }
    }
    
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations:[CLLocation])
    {
        if needsLocation
        {
            guard
                
                let currentLocation:CLLocation = locations.last
                
            else
            {
                return
            }
            
            let horizontalAccuracy:CLLocationAccuracy = currentLocation.horizontalAccuracy
            
            if horizontalAccuracy <= kDistanceAccuracy
            {
                needsLocation = false
                manager.stopUpdatingLocation()
                
                DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
                { [weak self] in
                    
                    self?.controller.locationFound(
                        currentLocation:currentLocation)
                    
                }
            }
        }
    }
}
