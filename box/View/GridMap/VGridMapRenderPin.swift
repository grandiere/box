import UIKit
import MapKit

class VGridMapRenderPin:MKAnnotationView
{
    init(annotation:MGridMapAnnotation)
    {
        let reuseIdentifier:String = VGridMapRenderPin.reusableIdentifier
        
        super.init(annotation:annotation, reuseIdentifier:reuseIdentifier)

        guard
        
            let image:UIImage = annotation.algo.annotationImage()
        
        else
        {
            return
        }
        
        self.image = image
        
        let offsetY:CGFloat = image.size.height / -2.0
        centerOffset = CGPoint(x: 0, y:offsetY)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
