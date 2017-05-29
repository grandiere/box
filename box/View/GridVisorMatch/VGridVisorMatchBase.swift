import UIKit

class VGridVisorMatchBase:UIView
{
    private weak var controller:CGridVisorMatch!
    private weak var buttonCancel:VGridVisorMatchBaseButton!
    private weak var buttonPlay:VGridVisorMatchBaseButton!
    private let kCornerRadius:CGFloat = 15
    private let kBorderWidth:CGFloat = 1
    private let kButtonSize:CGFloat = 50
    
    init(controller:CGridVisorMatch)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = kCornerRadius
        layer.borderWidth = kBorderWidth
        layer.borderColor = UIColor.black.cgColor
        self.controller = controller
        
        let blur:VBlur = VBlur.extraLight()
        
        let buttonCancel:VGridVisorMatchBaseButton = VGridVisorMatchBaseButton(
            image:#imageLiteral(resourceName: "assetGenericMap"),
            tintColor:UIColor.gridOrange)
        buttonCancel.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonPlay:VGridVisorMatchBaseButton = VGridVisorMatchBaseButton(
            image:#imageLiteral(resourceName: "assetGenericAge"),
            tintColor:UIColor.gridBlue)
        buttonPlay.addTarget(
            self,
            action:#selector(actionPlay(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(blur)
        addSubview(buttonCancel)
        addSubview(buttonPlay)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionCancel(sender button:VGridVisorMatchBaseButton)
    {
        
    }
    
    func actionPlay(sender button:VGridVisorMatchBaseButton)
    {
        
    }
}
