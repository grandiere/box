import UIKit

class VGridVirusOptions:UIView
{
    private weak var controller:CGridVirus!
    private weak var layoutCancelWidth:NSLayoutConstraint!
    
    init(controller:CGridVirus)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
        
        let buttonCancel:VGridVirusOptionsButton = VGridVirusOptionsButton(
            color:UIColor.gridOrange,
            title:NSLocalizedString("VGridVirusOptions_buttonCancel", comment:""))
        buttonCancel.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonRelease:VGridVirusOptionsButton = VGridVirusOptionsButton(
            color:UIColor.gridBlue,
            title:NSLocalizedString("VGridVirusOptions_buttonRelease", comment:""))
        buttonRelease.addTarget(
            self,
            action:#selector(actionRelease(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(buttonCancel)
        addSubview(buttonRelease)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonCancel,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:buttonCancel,
            toView:self)
        layoutCancelWidth = NSLayoutConstraint.width(
            view:buttonCancel)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonRelease,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:buttonRelease,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:buttonRelease,
            toView:buttonCancel)
        
        guard
        
            let energy:Int16 = MSession.sharedInstance.settings?.energy?.amount
        
        else
        {
            return
        }
        
        if energy < controller.model.kEnergyRequired
        {
            buttonRelease.notActive()
        }
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let width_2:CGFloat = width / 2.0
        layoutCancelWidth.constant = width_2
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionRelease(sender button:VGridVirusOptionsButton)
    {
        controller.releaseVirus()
    }
    
    func actionCancel(sender button:VGridVirusOptionsButton)
    {
        controller.back()
    }
}
