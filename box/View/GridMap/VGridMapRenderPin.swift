import UIKit
import MapKit

class VGridMapRenderPin:MKAnnotationView
{
    private let kAlphaSelected:CGFloat = 1
    private let kAlphaNotSelected:CGFloat = 0.4
    
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
        if isSelected || isHighlighted
        {
            alpha = kAlphaSelected
        }
        else
        {
            alpha = kAlphaNotSelected
        }
    }
}
