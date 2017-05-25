import UIKit

class VGridVisorMenuButton:UIButton
{
    private let kAlphaNotSelected:CGFloat = 1
    private let kAlphaSelected:CGFloat = 0.3
    private let kAnimationDuration:TimeInterval = 0.5
    
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
        alpha = 0
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
    
    //MARK: public
    
    func animate(show:Bool)
    {
        let alpha:CGFloat
        
        if show
        {
            alpha = 1
            isUserInteractionEnabled = true
        }
        else
        {
            alpha = 0
            isUserInteractionEnabled = false
        }
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.alpha = alpha
        }
    }
}
