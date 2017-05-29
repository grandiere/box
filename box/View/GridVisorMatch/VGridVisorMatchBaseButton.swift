import UIKit

class VGridVisorMatchBaseButton:UIButton
{
    init(image:UIImage, tintColor:UIColor)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
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
}
