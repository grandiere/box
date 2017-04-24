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
}
