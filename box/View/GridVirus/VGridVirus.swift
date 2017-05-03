import UIKit

class VGridVirus:VView
{
    private weak var controller:CGridVirus!
    private let kImageHeight:CGFloat = 140
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CGridVirus
        
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:17),
            NSForegroundColorAttributeName:UIColor.white]
        let attributesSubtitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:16),
            NSForegroundColorAttributeName:UIColor.white]
        let attributesEnergy:[String:AnyObject] = [
            NSFontAttributeName:UIFont.numeric(size:22),
            NSForegroundColorAttributeName:UIColor.gridBlue]
        let rawStringEnergy:String = "\(self.controller.model.kEnergyRequired)"
        
        let stringTitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VGridVirus_labelTitle", comment:""),
            attributes:attributesTitle)
        let stringSubtitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VGridVirus_labelSubtitle", comment:""),
            attributes:attributesSubtitle)
        let stringEnergy:NSAttributedString = NSAttributedString(
            string:rawStringEnergy,
            attributes:attributesEnergy)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringTitle)
        mutableString.append(stringSubtitle)
        mutableString.append(stringEnergy)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.image = #imageLiteral(resourceName: "assetGenericVirusEgg")
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.attributedText = mutableString
        
        addSubview(imageView)
        addSubview(label)
        
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
