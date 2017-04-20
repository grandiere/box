import UIKit

class VGridVisorDetailCellDebug:VGridVisorDetailCell
{
    private weak var labelEnergy:UILabel!
    private weak var buttonDebug:UIButton!
    private weak var modelDebug:MGridVisorDetailItemDebug?
    private let stringEnergyTitle:NSAttributedString
    private let attributesEnergy:[String:AnyObject]
    private let kTitleHeight:CGFloat = 50
    private let kEnergyLeft:CGFloat = 10
    private let kEnergyHeight:CGFloat = 40
    private let kEnergyWidth:CGFloat = 200
    private let kImageHeight:CGFloat = 160
    private let kButtonDebugWidth:CGFloat = 120
    private let kAlphaActive:CGFloat = 1
    private let kAlphaInactive:CGFloat = 0.3
    
    override init(frame:CGRect)
    {
        let attributesEnergyTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:13),
            NSForegroundColorAttributeName:UIColor(white:0, alpha:0.7)]
        attributesEnergy = [
            NSFontAttributeName:UIFont.numeric(size:24),
            NSForegroundColorAttributeName:UIColor.black]
        
        stringEnergyTitle = NSAttributedString(
            string:NSLocalizedString("VGridVisorDetailCellDebug_energyTitle", comment:""),
            attributes:attributesEnergyTitle)
        
        super.init(frame:frame)
        backgroundColor = UIColor.clear
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.bold(size:13)
        labelTitle.textColor = UIColor.black
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.text = NSLocalizedString("VGridVisorDetailCellDebug_labelTitle", comment:"")
        
        let labelEnergy:UILabel = UILabel()
        labelEnergy.translatesAutoresizingMaskIntoConstraints = false
        labelEnergy.backgroundColor = UIColor.clear
        labelEnergy.isUserInteractionEnabled = false
        self.labelEnergy = labelEnergy
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.image = #imageLiteral(resourceName: "assetGenericDebug")
        
        let buttonDebug:UIButton = UIButton()
        buttonDebug.translatesAutoresizingMaskIntoConstraints = false
        buttonDebug.setImage(
            #imageLiteral(resourceName: "assetGenericEnter").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonDebug.setImage(
            #imageLiteral(resourceName: "assetGenericEnter").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonDebug.imageView!.clipsToBounds = true
        buttonDebug.imageView!.contentMode = UIViewContentMode.center
        buttonDebug.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        self.buttonDebug = buttonDebug
        
        addSubview(labelTitle)
        addSubview(labelEnergy)
        addSubview(imageView)
        addSubview(buttonDebug)
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        NSLayoutConstraint.height(
            view:imageView,
            constant:kImageHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:labelEnergy,
            toView:imageView)
        NSLayoutConstraint.height(
            view:labelEnergy,
            constant:kEnergyHeight)
        NSLayoutConstraint.leftToLeft(
            view:labelEnergy,
            toView:self,
            constant:kEnergyLeft)
        NSLayoutConstraint.width(
            view:labelEnergy,
            constant:kEnergyWidth)
        
        NSLayoutConstraint.topToBottom(
            view:buttonDebug,
            toView:imageView)
        NSLayoutConstraint.height(
            view:buttonDebug,
            constant:kEnergyHeight)
        NSLayoutConstraint.rightToRight(
            view:buttonDebug,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonDebug,
            constant:kButtonDebugWidth)
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
        guard
            
            let modelDebug:MGridVisorDetailItemDebug = self.modelDebug
        
        else
        {
            return
        }
        
        controller?.enterDebug(modelDebug:modelDebug)
    }
}
