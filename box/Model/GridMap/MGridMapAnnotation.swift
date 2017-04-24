import UIKit
import MapKit

class MGridMapAnnotation:NSObject, MKAnnotation
{
    var coordinate:CLLocationCoordinate2D
    let reusableIdentifier:String
    let image:UIImage
    
    init(coordinate:CLLocationCoordinate2D)
    {
        reusableIdentifier = VCreateMapPin.reusableIdentifier
        self.coordinate = coordinate
        index = 0
        title = " "
        
        super.init()
    }
    
    //MARK: public
    
    func view() -> MKAnnotationView
    {
        let view:MKAnnotationView = VCreateMapPin(annotation:self)
        
        return view
    }
}
