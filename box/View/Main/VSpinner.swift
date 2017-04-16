import UIKit

class VSpinner:UIImageView
{
    private let kAnimationDuration:TimeInterval = 0.7
    
    init()
    {
        super.init(frame:CGRect.zero)
        
        let images:[UIImage] = [
            #imageLiteral(resourceName: "assetSpinner0"),
            #imageLiteral(resourceName: "assetSpinner1"),
            #imageLiteral(resourceName: "assetSpinner2"),
            #imageLiteral(resourceName: "assetSpinner3")
        ]
        
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        animationDuration = kAnimationDuration
        animationImages = images
        contentMode = UIViewContentMode.center
        startAnimating()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
