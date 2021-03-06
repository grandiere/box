import UIKit

class VGridVisorMatchBase:UIView
{
    private(set) weak var viewBackground:VGridVisorMatchBaseBackground!
    private weak var controller:CGridVisorMatch!
    private weak var buttonCancel:VGridVisorMatchBaseButton!
    private weak var buttonPlay:VGridVisorMatchBaseButton!
    private weak var layoutCancelTop:NSLayoutConstraint!
    private weak var layoutPlayTop:NSLayoutConstraint!
    private let algoHeight_2:CGFloat
    private let kButtonSize:CGFloat = 70
    private let kAlgoHeight:CGFloat = 90
    private let kAnimationDuration:TimeInterval = 0.3
    
    init(controller:CGridVisorMatch)
    {
        algoHeight_2 = kAlgoHeight / 2.0
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let buttonSize_2:CGFloat = kButtonSize / 2.0
        
        let viewBackground:VGridVisorMatchBaseBackground = VGridVisorMatchBaseBackground(
            controller:controller)
        self.viewBackground = viewBackground
        
        let viewAlgo:VGridVisorMatchBaseAlgo = VGridVisorMatchBaseAlgo(
            controller:controller)

        let buttonCancel:VGridVisorMatchBaseButton = VGridVisorMatchBaseButton(
            image:#imageLiteral(resourceName: "assetGenericCancel"),
            tintColor:UIColor.gridOrange)
        buttonCancel.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonCancel = buttonCancel
        
        let buttonPlay:VGridVisorMatchBaseButton = VGridVisorMatchBaseButton(
            image:#imageLiteral(resourceName: "assetGenericPlay"),
            tintColor:UIColor.gridBlue)
        buttonPlay.addTarget(
            self,
            action:#selector(actionPlay(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonPlay = buttonPlay
        
        addSubview(viewBackground)
        addSubview(viewAlgo)
        addSubview(buttonCancel)
        addSubview(buttonPlay)
        
        NSLayoutConstraint.topToTop(
            view:viewBackground,
            toView:self,
            constant:algoHeight_2)
        NSLayoutConstraint.bottomToBottom(
            view:viewBackground,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:viewBackground,
            toView:self,
            constant:buttonSize_2)
        NSLayoutConstraint.rightToRight(
            view:viewBackground,
            toView:self,
            constant:-buttonSize_2)
        
        layoutPlayTop = NSLayoutConstraint.topToTop(
            view:buttonPlay,
            toView:self)
        NSLayoutConstraint.size(
            view:buttonPlay,
            constant:kButtonSize)
        NSLayoutConstraint.rightToRight(
            view:buttonPlay,
            toView:self)
        
        layoutCancelTop = NSLayoutConstraint.topToTop(
            view:buttonCancel,
            toView:self)
        NSLayoutConstraint.size(
            view:buttonCancel,
            constant:kButtonSize)
        NSLayoutConstraint.leftToLeft(
            view:buttonCancel,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewAlgo,
            toView:self)
        NSLayoutConstraint.height(
            view:viewAlgo,
            constant:kAlgoHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewAlgo,
            toView:self)
        
        if let credits:Int = controller.model?.credits
        {
            guard
            
                let energy:Int = MSession.sharedInstance.settings?.energy?.percentEnergy()
            
            else
            {
                return
            }
            
            if credits > energy
            {
                buttonPlay.deactivate(image:#imageLiteral(resourceName: "assetGenericNoEnergy"))
            }
        }
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.maxY + algoHeight_2
        let remainHeight:CGFloat = height - kButtonSize
        let marginTop:CGFloat = remainHeight / 2.0
        layoutPlayTop.constant = marginTop
        layoutCancelTop.constant = marginTop
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionCancel(sender button:VGridVisorMatchBaseButton)
    {
        button.isUserInteractionEnabled = false
        controller.back()
    }
    
    func actionPlay(sender button:VGridVisorMatchBaseButton)
    {
        button.isUserInteractionEnabled = false
        buttonCancel.isUserInteractionEnabled = false
        controller.viewMatch.buttonCancel.isUserInteractionEnabled = false
        animateMatch()
    }
    
    //MARK: private
    
    private func animateMatch()
    {
        UIView.animate(
            withDuration:kAnimationDuration,
        animations:
        { [weak self] in
            
            self?.buttonCancel.alpha = 0
            self?.buttonPlay.alpha = 0
            
        })
        { [weak self] (done:Bool) in
            
            self?.controller.play()
        }
    }
}
