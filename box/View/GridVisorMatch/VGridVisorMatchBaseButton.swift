import UIKit

class VGridVisorMatchBaseButton:UIButton
{
    private let kBorderWidth:CGFloat = 2
    
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
        layer.borderWidth = kBorderWidth
        layer.borderColor = UIColor(white:0, alpha:0.3).cgColor
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
