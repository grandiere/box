import UIKit
import MapKit

class VGridMapRenderPin:MKAnnotationView
{
    init(annotation:MGridMapAnnotation)
    {
        let reuseIdentifier:String = VGridMapRenderPin.reusableIdentifier
        let offsetY:CGFloat = annotation.image.size.height / -2.0
        
        super.init(annotation:annotation, reuseIdentifier:reuseIdentifier)
        canShowCallout = true
        image = UIImage(named:"mapAnnotation")
        centerOffset = CGPoint(x: 0, y: offsetY)
        leftCalloutAccessoryView = leftCallOut
        rightCalloutAccessoryView = rightCallOut
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
