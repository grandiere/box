import UIKit

class VGridVisorMatchBase:UIView
{
    private weak var controller:CGridVisorMatch!
    private weak var buttonCancel:VGridVisorMatchBaseButton!
    private weak var buttonPlay:VGridVisorMatchBaseButton!
    private weak var imageView:UIImageView!
    private weak var layoutCancelTop:NSLayoutConstraint!
    private weak var layoutPlayTop:NSLayoutConstraint!
    private let kCornerRadius:CGFloat = 15
    private let kBorderWidth:CGFloat = 1
    private let kButtonSize:CGFloat = 70
    
    init(controller:CGridVisorMatch)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let buttonSize_2:CGFloat = kButtonSize / 2.0
        
        let viewBackground:UIView = UIView()
        viewBackground.isUserInteractionEnabled = false
        viewBackground.translatesAutoresizingMaskIntoConstraints = false
        viewBackground.clipsToBounds = true
        viewBackground.layer.borderWidth = kBorderWidth
        viewBackground.layer.borderColor = UIColor(white:1, alpha:0.3).cgColor
        viewBackground.layer.cornerRadius = kCornerRadius
        
        let blur:VBlur = VBlur.light()
        
        let buttonCancel:VGridVisorMatchBaseButton = VGridVisorMatchBaseButton(
            image:#imageLiteral(resourceName: "assetGenericCancel"),
            tintColor:UIColor.gridOrange)
        buttonCancel.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonPlay:VGridVisorMatchBaseButton = VGridVisorMatchBaseButton(
            image:#imageLiteral(resourceName: "assetGenericPlay"),
            tintColor:UIColor.gridBlue)
        buttonPlay.addTarget(
            self,
            action:#selector(actionPlay(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.center
        imageView.clipsToBounds = true
        imageView.image = controller.model?.icon
        self.imageView = imageView
        
        viewBackground.addSubview(blur)
        addSubview(viewBackground)
        addSubview(imageView)
        addSubview(buttonCancel)
        addSubview(buttonPlay)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.equalsVertical(
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
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.maxY
        let remainHeight:CGFloat = height - kButtonSize
        let marginTop:CGFloat = remainHeight / 2.0
        layoutPlayTop.constant = marginTop
        layoutCancelTop.constant = marginTop
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionCancel(sender button:VGridVisorMatchBaseButton)
    {
        
    }
    
    func actionPlay(sender button:VGridVisorMatchBaseButton)
    {
        
    }
}
