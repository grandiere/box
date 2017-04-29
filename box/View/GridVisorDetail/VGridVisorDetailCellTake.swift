import UIKit

class VGridVisorDetailCellTake:VGridVisorDetailCell
{
    private let kButtonTop:CGFloat = 10
    private let kButtonHeight:CGFloat = 90
    private let kButtonWidth:CGFloat = 80
    private let kLabelWidth:CGFloat = 200
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        backgroundColor = UIColor.clear
        
        let labelTitle:UILabel = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.isUserInteractionEnabled = false
        labelTitle.textAlignment = NSTextAlignment.right
        labelTitle.font = UIFont.bold(size:15)
        labelTitle.textColor = UIColor.black
        labelTitle.text = NSLocalizedString("VGridVisorDetailCellTake_labelTitle", comment:"")
        
        let buttonTake:UIButton = UIButton()
        buttonTake.translatesAutoresizingMaskIntoConstraints = false
        buttonTake.setImage(
            #imageLiteral(resourceName: "assetGenericMatch").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonTake.setImage(
            #imageLiteral(resourceName: "assetGenericMatchOver").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.highlighted)
        buttonTake.imageView!.clipsToBounds = true
        buttonTake.imageView!.contentMode = UIViewContentMode.center
        buttonTake.addTarget(
            self,
            action:#selector(actionTake(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(labelTitle)
        addSubview(buttonTake)
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self,
            constant:kButtonTop)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kButtonHeight)
        NSLayoutConstraint.rightToLeft(
            view:labelTitle,
            toView:buttonTake)
        NSLayoutConstraint.width(
            view:labelTitle,
            constant:kLabelWidth)
        
        NSLayoutConstraint.topToTop(
            view:buttonTake,
            toView:self,
            constant:kButtonTop)
        NSLayoutConstraint.height(
            view:buttonTake,
            constant:kButtonHeight)
        NSLayoutConstraint.rightToRight(
            view:buttonTake,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonTake,
            constant:kButtonWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionTake(sender button:UIButton)
    {
        controller?.enterMach()
    }
}
