import UIKit
import MapKit

class VGridMapRender:MKMapView, MKMapViewDelegate
{
    private weak var controller:CGridMap!
    private let span:MKCoordinateSpan
    private var userCoordinate:CLLocationCoordinate2D!
    private var shouldUpdate:Bool
    private let kSpanSize:CLLocationDegrees = 0.01
    
    init(controller:CGridMap)
    {
        span = MKCoordinateSpan(latitudeDelta:kSpanSize, longitudeDelta:kSpanSize)
        shouldUpdate = true
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        isRotateEnabled = false
        isScrollEnabled = true
        isZoomEnabled = true
        isPitchEnabled = false
        mapType = MKMapType.standard
        showsBuildings = true
        showsPointsOfInterest = true
        showsCompass = true
        showsScale = false
        showsTraffic = false
        delegate = self
        showsUserLocation = true
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func centerLocation(locationCoordinate:CLLocationCoordinate2D)
    {
        let region:MKCoordinateRegion = MKCoordinateRegionMake(locationCoordinate, span)
        setRegion(region, animated:true)
    }
    
    //MARK: public
    
    func centerOnUser()
    {
        guard
            
            let userCoordinated:CLLocationCoordinate2D = userLocation.location?.coordinate
        
        else
        {
            return
        }
        
        selectAnnotation(userLocation, animated:true)
        centerLocation(locationCoordinate:userCoordinated)
    }
    
    //MARK: map delegate
    
    func mapView(_ mapView:MKMapView, viewFor annotation:MKAnnotation) -> MKAnnotationView?
    {
        guard
            
            let modelAnnotation:MGridMapAnnotation = annotation as? MGridMapAnnotation
        
        else
        {
            return nil
        }
        
        var view:VGridMapRenderPin? = mapView.dequeueReusableAnnotationView(
            withIdentifier:
            VGridMapRenderPin.reusableIdentifier) as? VGridMapRenderPin
        
        if view == nil
        {
            view = VGridMapRenderPin(annotation:modelAnnotation)
        }
        else
        {
            view!.annotation = modelAnnotation
        }
        
        view?.hover()
        
        return view
    }
    
    func mapView(_ mapView:MKMapView, didSelect view:MKAnnotationView)
    {
        guard
        
            let annotation:MGridMapAnnotation = view.annotation as? MGridMapAnnotation
        
        else
        {
            return
        }
        
        let coordinates:CLLocationCoordinate2D = annotation.coordinate
        centerLocation(locationCoordinate:coordinates)
        controller.viewMap.showDetail(annotation:annotation)
    }
    
    func mapView(_ mapView:MKMapView, didDeselect view:MKAnnotationView)
    {
        controller.viewMap.hideDetail()
    }
    
    func mapView(_ mapView:MKMapView, didUpdate userLocation:MKUserLocation)
    {
        if shouldUpdate
        {
            shouldUpdate = false
            centerLocation(locationCoordinate:userLocation.coordinate)
        }
    }
}
