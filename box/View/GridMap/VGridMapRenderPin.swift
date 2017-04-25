import UIKit
import MapKit

class VGridMapRenderPin:MKAnnotationView
{
    init(annotation:MGridMapAnnotation)
    {
        let reuseIdentifier:String = VGridMapRenderPin.reusableIdentifier
        
        super.init(annotation:annotation, reuseIdentifier:reuseIdentifier)
        hover()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        guard
            
            let annotation:MGridMapAnnotation = self.annotation as? MGridMapAnnotation
            
        else
        {
            return
        }
        
        let imageAnnotation:UIImage
        
        if isSelected || isHighlighted
        {
            guard
            
                let image:UIImage = annotation.algo.annotationImageOn()
            
            else
            {
                return
            }
            
            imageAnnotation = image
        }
        else
        {
            guard
            
                let image:UIImage = annotation.algo.annotationImageOff()
            
            else
            {
                return
            }
            
            imageAnnotation = image
        }
        
        self.image = imageAnnotation
        
        let offsetY:CGFloat = imageAnnotation.size.height / -2.0
        centerOffset = CGPoint(x: 0, y:offsetY)
    }
}
