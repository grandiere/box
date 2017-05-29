import UIKit

class VGridVisorMatchBaseButton:UIButton
{
    init(image:UIImage, tintColor:UIColor)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor(white:1, alpha:0.2)
        translatesAutoresizingMaskIntoConstraints = false
        setImage(
            image.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        setImage(
            image.withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        imageView!.tintColor = tintColor
        imageView!.clipsToBounds = true
        imageView!.contentMode = UIViewContentMode.center
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let width_2:CGFloat = width / 2.0
        layer.cornerRadius = width_2
        
        super.layoutSubviews()
    }
}
