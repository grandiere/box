import UIKit

class VGridVirus:VView
{
    private weak var controller:CGridVirus!
    private weak var layoutOptionsLeft:NSLayoutConstraint!
    private let kImageTop:CGFloat = 160
    private let kImageHeight:CGFloat = 80
    private let kLabelHorizontalMargin:CGFloat = 10
    private let kLabelHeight:CGFloat = 150
    private let kOptionsWidth:CGFloat = 260
    private let kOptionsHeight:CGFloat = 35
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CGridVirus
        
        MSession.sharedInstance.settings?.energy?.tryUpdateEnergy()
        
        guard
            
            let energy:Int16 = MSession.sharedInstance.settings?.energy?.amount
            
        else
        {
            return
        }
        
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:17),
            NSForegroundColorAttributeName:UIColor.white]
        let attributesSubtitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:17),
            NSForegroundColorAttributeName:UIColor(white:1, alpha:0.7)]
        let attributesEnergy:[String:AnyObject] = [
            NSFontAttributeName:UIFont.numeric(size:20),
            NSForegroundColorAttributeName:UIColor.white]
        let rawStringEnergy:String = "\(self.controller.model.kEnergyRequired)"
        let rawCurrentEnergy:String = "\(energy)"
        
        let stringTitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VGridVirus_labelTitle", comment:""),
            attributes:attributesTitle)
        let stringSubtitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VGridVirus_labelSubtitle", comment:""),
            attributes:attributesSubtitle)
        let stringEnergy:NSAttributedString = NSAttributedString(
            string:rawStringEnergy,
            attributes:attributesEnergy)
        let stringCurrent:NSAttributedString = NSAttributedString(
            string:rawCurrentEnergy,
            attributes:attributesEnergy)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringTitle)
        mutableString.append(stringEnergy)
        mutableString.append(stringSubtitle)
        mutableString.append(stringCurrent)
        
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
        
        let options:VGridVirusOptions = VGridVirusOptions(
            controller:self.controller)
        
        addSubview(imageView)
        addSubview(label)
        addSubview(options)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self,
            constant:kImageTop)
        NSLayoutConstraint.height(
            view:imageView,
            constant:kImageHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:label,
            toView:imageView)
        NSLayoutConstraint.height(
            view:label,
            constant:kLabelHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self,
            margin:kLabelHorizontalMargin)
        
        NSLayoutConstraint.topToBottom(
            view:options,
            toView:label)
        NSLayoutConstraint.height(
            view:options,
            constant:kOptionsHeight)
        layoutOptionsLeft = NSLayoutConstraint.leftToLeft(
            view:options,
            toView:self)
        NSLayoutConstraint.width(
            view:options,
            constant:kOptionsWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainWidth:CGFloat = width - kOptionsWidth
        let marginLeft:CGFloat = remainWidth / 2.0
        layoutOptionsLeft.constant = marginLeft
        
        super.layoutSubviews()
    }
}
