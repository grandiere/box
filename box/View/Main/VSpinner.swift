import UIKit

class VSpinner:UIImageView
{
    private let kAnimationDuration:TimeInterval = 5
    
    init()
    {
        super.init(frame:CGRect.zero)
        
        let images:[UIImage] = [
            #imageLiteral(resourceName: "assetGenericSpinner0"),
            #imageLiteral(resourceName: "assetGenericSpinner1"),
            #imageLiteral(resourceName: "assetGenericSpinner2"),
            #imageLiteral(resourceName: "assetGenericSpinner3"),
            #imageLiteral(resourceName: "assetGenericSpinner4"),
            #imageLiteral(resourceName: "assetGenericSpinner5"),
            #imageLiteral(resourceName: "assetGenericSpinner6"),
            #imageLiteral(resourceName: "assetGenericSpinner7"),
            #imageLiteral(resourceName: "assetGenericSpinner8")
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
