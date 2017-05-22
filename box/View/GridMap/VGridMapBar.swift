import UIKit

class VGridMapBar:UIView
{
    private weak var controller:CGridMap!
    private weak var labelCount:UILabel!
    private let kBorderHeight:CGFloat = 1
    private let kButtonWidth:CGFloat = 60
    
    init(controller:CGridMap)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let blur:VBlur = VBlur.light()
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.4))
        
        let labelCount:UILabel = UILabel()
        labelCount.isUserInteractionEnabled = false
        labelCount.translatesAutoresizingMaskIntoConstraints = false
        labelCount.backgroundColor = UIColor.clear
        labelCount.textAlignment = NSTextAlignment.center
        labelCount.font = UIFont.regular(size:14)
        labelCount.textColor = UIColor.black
        self.labelCount = labelCount
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBackBlack").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBackBlack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.contentMode = UIViewContentMode.center
        backButton.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        backButton.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonUser:UIButton = UIButton()
        buttonUser.translatesAutoresizingMaskIntoConstraints = false
        buttonUser.setImage(
            #imageLiteral(resourceName: "assetGenericMapUser").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonUser.setImage(
            #imageLiteral(resourceName: "assetGenericMapUser").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonUser.imageView!.contentMode = UIViewContentMode.center
        buttonUser.imageView!.clipsToBounds = true
        buttonUser.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        buttonUser.addTarget(
            self,
            action:#selector(actionUser(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(blur)
        addSubview(border)
        addSubview(labelCount)
        addSubview(backButton)
        addSubview(buttonUser)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:labelCount,
            toView:self)
        
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        NSLayoutConstraint.equalsVertical(
            view:backButton,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:backButton,
            toView:self)
        NSLayoutConstraint.width(
            view:backButton,
            constant:kButtonWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonUser,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:buttonUser,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonUser,
            constant:kButtonWidth)
        
        let countInt:Int = controller.modelAlgo.items.count
        let countNumber:NSNumber = countInt as NSNumber
        let numberFormatter:NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        guard
            
            let numberString:String = numberFormatter.string(from:countNumber)
        
        else
        {
            return
        }
        
        let countString:String = String(
            format:NSLocalizedString("VGridMapBar_labelCount", comment:""),
            numberString)
        
        labelCount.text = countString
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
    
    func actionUser(sender button:UIButton)
    {
        controller.viewMap.viewRender.centerOnUser()
    }
}
