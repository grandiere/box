import UIKit

class VGridVisorDetailCellMatch:VGridVisorDetailCell
{
    private weak var labelEnergy:UILabel!
    private weak var buttonMatch:UIButton!
    private weak var modelMatch:MGridVisorDetailItemMatch?
    private let stringEnergyTitle:NSAttributedString
    private let attributesMatchTitle:[String:AnyObject]
    private let attributesEnergy:[String:AnyObject]
    private let kButtonTop:CGFloat = 10
    private let kButtonHeight:CGFloat = 90
    private let kButtonWidth:CGFloat = 80
    private let kLabelWidth:CGFloat = 200
    private let kAlphaActive:CGFloat = 1
    private let kAlphaInactive:CGFloat = 0.2
    
    override init(frame:CGRect)
    {
        let attributesEnergyTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:13),
            NSForegroundColorAttributeName:UIColor(white:0, alpha:0.8)]
        attributesMatchTitle = [
            NSFontAttributeName:UIFont.bold(size:15),
            NSForegroundColorAttributeName:UIColor.black]
        attributesEnergy = [
            NSFontAttributeName:UIFont.numeric(size:30),
            NSForegroundColorAttributeName:UIColor.black]
        
        stringEnergyTitle = NSAttributedString(
            string:NSLocalizedString("VGridVisorDetailCellMatch_energyTitle", comment:""),
            attributes:attributesEnergyTitle)
        
        super.init(frame:frame)
        backgroundColor = UIColor.clear
        
        let labelEnergy:UILabel = UILabel()
        labelEnergy.translatesAutoresizingMaskIntoConstraints = false
        labelEnergy.backgroundColor = UIColor.clear
        labelEnergy.isUserInteractionEnabled = false
        labelEnergy.textAlignment = NSTextAlignment.right
        labelEnergy.numberOfLines = 0
        self.labelEnergy = labelEnergy
        
        let buttonMatch:UIButton = UIButton()
        buttonMatch.translatesAutoresizingMaskIntoConstraints = false
        buttonMatch.setImage(
            #imageLiteral(resourceName: "assetGenericMatch").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonMatch.setImage(
            #imageLiteral(resourceName: "assetGenericMatchOver").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.highlighted)
        buttonMatch.imageView!.clipsToBounds = true
        buttonMatch.imageView!.contentMode = UIViewContentMode.center
        buttonMatch.addTarget(
            self,
            action:#selector(actionMatch(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonMatch = buttonMatch
        
        addSubview(labelEnergy)
        addSubview(buttonMatch)
        
        NSLayoutConstraint.topToTop(
            view:labelEnergy,
            toView:self,
            constant:kButtonTop)
        NSLayoutConstraint.height(
            view:labelEnergy,
            constant:kButtonHeight)
        NSLayoutConstraint.rightToLeft(
            view:labelEnergy,
            toView:buttonMatch)
        NSLayoutConstraint.width(
            view:labelEnergy,
            constant:kLabelWidth)
        
        NSLayoutConstraint.topToTop(
            view:buttonMatch,
            toView:self,
            constant:kButtonTop)
        NSLayoutConstraint.height(
            view:buttonMatch,
            constant:kButtonHeight)
        NSLayoutConstraint.rightToRight(
            view:buttonMatch,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonMatch,
            constant:kButtonWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(controller:CGridVisorDetail, model:MGridVisorDetailItem)
    {
        super.config(controller:controller, model:model)
        
        guard
            
            let modelMatch:MGridVisorDetailItemMatch = model as? MGridVisorDetailItemMatch
            
        else
        {
            return
        }
        
        self.modelMatch = modelMatch
        let credits:Int = modelMatch.credits
        let rawString:String = "\(credits)"
        
        let stringCredits:NSAttributedString = NSAttributedString(
            string:rawString,
            attributes:attributesEnergy)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        if let titleString:String = modelMatch.title
        {
            let stringMatchTitle:NSAttributedString = NSAttributedString(
                string:titleString,
                attributes:attributesMatchTitle)
            mutableString.append(stringMatchTitle)
        }
        
        mutableString.append(stringEnergyTitle)
        mutableString.append(stringCredits)
        
        labelEnergy.attributedText = mutableString
        
        guard
            
            let energy:Int = MSession.sharedInstance.settings?.energy?.percentEnergy()
            
        else
        {
            return
        }
        
        if credits > energy
        {
            buttonMatch.isUserInteractionEnabled = false
            buttonMatch.alpha = kAlphaInactive
        }
        else
        {
            buttonMatch.isUserInteractionEnabled = true
            buttonMatch.alpha = kAlphaActive
        }
    }
    
    //MARK: actions
    
    func actionMatch(sender button:UIButton)
    {
        controller?.enterTake()
    }
}
