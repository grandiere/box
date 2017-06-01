import UIKit

class VGridVisorMatch:VView
{
    private(set) weak var buttonCancel:UIButton!
    private(set) weak var viewBase:VGridVisorMatchBase!
    private weak var controller:CGridVisorMatch!
    private weak var layoutBaseTop:NSLayoutConstraint!
    private let kBaseMarginHorizontal:CGFloat = 10
    private let kBaseHeight:CGFloat = 180
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CGridVisorMatch
        
        let viewBase:VGridVisorMatchBase = VGridVisorMatchBase(
            controller:self.controller)
        self.viewBase = viewBase
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.backgroundColor = UIColor.clear
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.clipsToBounds = true
        buttonCancel.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonCancel = buttonCancel
        
        addSubview(buttonCancel)
        addSubview(viewBase)
        
        NSLayoutConstraint.equals(
            view:buttonCancel,
            toView:self)
        
        layoutBaseTop = NSLayoutConstraint.topToTop(
            view:viewBase,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBase,
            constant:kBaseHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBase,
            toView:self,
            margin:kBaseMarginHorizontal)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.maxY
        let remainHeight:CGFloat = height - kBaseHeight
        let marginTop:CGFloat = remainHeight / 2.0
        layoutBaseTop.constant = marginTop
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionCancel(sender button:UIButton)
    {
        controller.back()
    }
}
