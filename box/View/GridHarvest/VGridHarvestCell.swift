import UIKit

class VGridHarvestCell:UICollectionViewCell
{
    private weak var labelLevel:UILabel!
    private weak var labelKills:UILabel!
    private weak var labelAge:UILabel!
    private let kImageMargin:CGFloat = 10
    private let kImageWidth:CGFloat = 60
    private let kLabelsWidth:CGFloat = 90
    
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
        
        let labelLevel:UILabel = UILabel()
        labelLevel.isUserInteractionEnabled = false
        labelLevel.translatesAutoresizingMaskIntoConstraints = false
        labelLevel.backgroundColor = UIColor.clear
        labelLevel.textAlignment = NSTextAlignment.center
        labelLevel.font = UIFont.bold(size:18)
        labelLevel.textColor = UIColor.white
        self.labelLevel = labelLevel
        
        let labelKills:UILabel = UILabel()
        labelKills.translatesAutoresizingMaskIntoConstraints = false
        labelKills.isUserInteractionEnabled = false
        labelKills.backgroundColor = UIColor.clear
        labelKills.textAlignment = NSTextAlignment.center
        labelKills.font = UIFont.bold(size:18)
        labelKills.textColor = UIColor.white
        self.labelKills = labelKills
        
        let labelAge:UILabel = UILabel()
        labelAge.translatesAutoresizingMaskIntoConstraints = false
        labelAge.isUserInteractionEnabled = false
        labelAge.backgroundColor = UIColor.clear
        labelAge.textAlignment = NSTextAlignment.center
        labelAge.font = UIFont.regular(size:10)
        labelAge.textColor = UIColor.white
        self.labelAge = labelAge
        
        addSubview(imageView)
        addSubview(labelLevel)
        addSubview(labelKills)
        addSubview(labelAge)
        
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
        
        NSLayoutConstraint.equalsVertical(
            view:labelAge,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:labelAge,
            toView:self)
        NSLayoutConstraint.width(
            view:labelAge,
            constant:kLabelsWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:labelKills,
            toView:self)
        NSLayoutConstraint.rightToLeft(
            view:labelKills,
            toView:labelAge)
        NSLayoutConstraint.width(
            view:labelKills,
            constant:kLabelsWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:labelLevel,
            toView:self)
        NSLayoutConstraint.rightToLeft(
            view:labelLevel,
            toView:labelKills)
        NSLayoutConstraint.width(
            view:labelLevel,
            constant:kLabelsWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(virus:MGridAlgoItemHostileVirusFriendly)
    {
        labelLevel.text = "\(virus.level)"
        labelKills.text = "\(virus.defeated)"
        labelAge.text = virus.age()
    }
}
