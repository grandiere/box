import UIKit
import MapKit

class VGridMapRender:MKMapView, MKMapViewDelegate
{
    private weak var controller:CGridMap!
    private let span:MKCoordinateSpan
    private var userCoordinate:CLLocationCoordinate2D!
    private let kSpanSize:CLLocationDegrees = 0.01
    
    init(controller:CGridMap)
    {
        span = MKCoordinateSpan(latitudeDelta:kSpanSize, longitudeDelta:kSpanSize)
        
        super.init(frame:CGRect.zero)
        self.controller = controller
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
        showsScale = true
        showsTraffic = false
        delegate = self
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func centerLocation(locationCoordinate:CLLocationCoordinate2D)
    {
        let region:MKCoordinateRegion = MKCoordinateRegionMake(locationCoordinate, span)
        setRegion(region, animated:true)
    }
    
    //MARK: map delegate
    
    func mapView(_ mapView:MKMapView, viewFor annotation:MKAnnotation) -> MKAnnotationView?
    {
        let modelAnnotation:MCreateAnnotation = annotation as! MCreateAnnotation
        let reusableIdentifier:String = modelAnnotation.reusableIdentifier
        var view:MKAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: reusableIdentifier)
        
        if view == nil
        {
            view = modelAnnotation.view()
        }
        else
        {
            view!.annotation = modelAnnotation
        }
        
        return view
    }
    
    func mapView(_ mapView:MKMapView, didSelect view:MKAnnotationView)
    {
        controller.viewCreate.showingCallout()
        
        guard
            
            let annotation:MCreateAnnotation = view.annotation as? MCreateAnnotation
            
            else
        {
            return
        }
        
        controller.viewCreate.history.selectLocation(item:annotation)
    }
    
    func mapView(_ mapView:MKMapView, didDeselect view:MKAnnotationView)
    {
        controller.cancelMove()
        controller.viewCreate.notShowingCallout()
        controller.viewCreate.history.clearSelection()
    }
}
