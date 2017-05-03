import UIKit

class VGridVirus:VView
{
    private weak var controller:CGridVirus!
    private let kImageHeight:CGFloat = 140
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CGridVirus
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.image = #imageLiteral(resourceName: "assetGenericVirusEgg")
        
        addSubview(imageView)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        NSLayoutConstraint.height(
            view:imageView,
            constant:kImageHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
