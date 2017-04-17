import UIKit

class VGridVisorBarEnergy:UIView
{
    private weak var controller:CGridVisor!
    private weak var image:UIImageView!
    
    init(controller:CGridVisor)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        self.controller = controller
        
        let image:UIImageView = UIImageView()
        image.isUserInteractionEnabled = false
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = UIViewContentMode.center
        self.image = image
        
        addSubview(image)
        
        NSLayoutConstraint.equals(
            view:image,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
