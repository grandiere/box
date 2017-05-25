import UIKit

class VGridVisorMenuButton:UIButton
{
    private let kAlphaNotSelected:CGFloat = 1
    private let kAlphaSelected:CGFloat = 0.3
    
    init(image:UIImage)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        setImage(
            image.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        setImage(
            image.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.highlighted)
        imageView!.clipsToBounds = true
        imageView!.contentMode = UIViewContentMode.center
    }
    
    required init?(coder:NSCoder)
    {
        return nil
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
