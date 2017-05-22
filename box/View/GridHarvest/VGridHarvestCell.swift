import UIKit

class VGridHarvestCell:UICollectionViewCell
{
    private weak var labelKills:UILabel!
    private weak var labelAge:UILabel!
    private let kImageMargin:CGFloat = 20
    private let kImageWidth:CGFloat = 60
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "assetTextureVirusFriendlyDetail")
        
        addSubview(imageView)
        
        NSLayoutConstraint.equalsVertical(
            view:imageView,
            toView:self,
            margin:kImageMargin)
        NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        NSLayoutConstraint.width(
            view:imageView,
            constant:kImageWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(virus:MGridAlgoItemHostileVirusFriendly)
    {
        
    }
}
