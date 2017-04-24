import UIKit

class VGridVisorDetailCellDebug:VGridVisorDetailCell
{
    private weak var labelEnergy:UILabel!
    private weak var buttonDebug:UIButton!
    private weak var modelDebug:MGridVisorDetailItemDebug?
    private let stringDebugTitle:NSAttributedString
    private let stringEnergyTitle:NSAttributedString
    private let attributesEnergy:[String:AnyObject]
    private let kButtonTop:CGFloat = 10
    private let kButtonHeight:CGFloat = 90
    private let kButtonWidth:CGFloat = 80
    private let kLabelWidth:CGFloat = 200
    private let kAlphaActive:CGFloat = 1
    private let kAlphaInactive:CGFloat = 0.2
    
    override init(frame:CGRect)
    {
        let attributesDebugTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:15),
            NSForegroundColorAttributeName:UIColor.black]
        let attributesEnergyTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:13),
            NSForegroundColorAttributeName:UIColor(white:0, alpha:0.8)]
        attributesEnergy = [
            NSFontAttributeName:UIFont.numeric(size:30),
            NSForegroundColorAttributeName:UIColor.black]
        
        stringDebugTitle = NSAttributedString(
            string:NSLocalizedString("VGridVisorDetailCellDebug_labelTitle", comment:""),
            attributes:attributesDebugTitle)
        stringEnergyTitle = NSAttributedString(
            string:NSLocalizedString("VGridVisorDetailCellDebug_energyTitle", comment:""),
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
        
        let buttonDebug:UIButton = UIButton()
        buttonDebug.translatesAutoresizingMaskIntoConstraints = false
        buttonDebug.setImage(
            #imageLiteral(resourceName: "assetGenericMatch").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonDebug.setImage(
            #imageLiteral(resourceName: "assetGenericMatchOver").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.highlighted)
        buttonDebug.imageView!.clipsToBounds = true
        buttonDebug.imageView!.contentMode = UIViewContentMode.center
        buttonDebug.addTarget(
            self,
            action:#selector(actionEnter(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonDebug = buttonDebug
        
        addSubview(labelEnergy)
        addSubview(buttonDebug)
        
        NSLayoutConstraint.topToTop(
            view:labelEnergy,
            toView:self,
            constant:kButtonTop)
        NSLayoutConstraint.height(
            view:labelEnergy,
            constant:kButtonHeight)
        NSLayoutConstraint.rightToLeft(
            view:labelEnergy,
            toView:buttonDebug)
        NSLayoutConstraint.width(
            view:labelEnergy,
            constant:kLabelWidth)
        
        NSLayoutConstraint.topToTop(
            view:buttonDebug,
            toView:self,
            constant:kButtonTop)
        NSLayoutConstraint.height(
            view:buttonDebug,
            constant:kButtonHeight)
        NSLayoutConstraint.rightToRight(
            view:buttonDebug,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonDebug,
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
            
            let modelDebug:MGridVisorDetailItemDebug = model as? MGridVisorDetailItemDebug
            
        else
        {
            return
        }
        
        self.modelDebug = modelDebug
        let credits:Int = modelDebug.credits
        let rawString:String = "\(credits)"
        let stringCredits:NSAttributedString = NSAttributedString(
            string:rawString,
            attributes:attributesEnergy)
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringDebugTitle)
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
            buttonDebug.isUserInteractionEnabled = false
            buttonDebug.alpha = kAlphaInactive
        }
        else
        {
            buttonDebug.isUserInteractionEnabled = true
            buttonDebug.alpha = kAlphaActive
        }
    }
    
    //MARK: actions
    
    func actionEnter(sender button:UIButton)
    {
        controller?.enterMach()
    }
}
