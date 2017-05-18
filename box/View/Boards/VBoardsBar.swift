import UIKit

class VBoardsBar:UIView
{
    private weak var controller:CBoards!
    private weak var viewSelector:VBoardsBarSelector!
    private weak var layoutSelectorLeft:NSLayoutConstraint!
    private let kSelectorWidth:CGFloat = 160
    private let kSelectorHeight:CGFloat = 35
    private let kSelectorBottom:CGFloat = -15
    private let kButtonWidth:CGFloat = 60
    private let kImageHeight:CGFloat = 70
    private let kBorderHeight:CGFloat = 1
    
    init(controller:CBoards)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.black
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.contentMode = UIViewContentMode.center
        backButton.imageView!.tintColor = UIColor.white
        backButton.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let imageView:UIImageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "assetGenericBoards")
        imageView.isUserInteractionEnabled = false
        
        let viewSelector:VBoardsBarSelector = VBoardsBarSelector(controller:controller)
        self.viewSelector = viewSelector
        
        let border:VBorder = VBorder(color:UIColor.gridBlue)
        
        addSubview(border)
        addSubview(imageView)
        addSubview(backButton)
        addSubview(viewSelector)
        
        NSLayoutConstraint.equalsVertical(
            view:backButton,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:backButton,
            toView:self)
        NSLayoutConstraint.width(
            view:backButton,
            constant:kButtonWidth)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        NSLayoutConstraint.height(
            view:imageView,
            constant:kImageHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewSelector,
            toView:self,
            constant:kSelectorBottom)
        NSLayoutConstraint.height(
            view:viewSelector,
            constant:kSelectorHeight)
        layoutSelectorLeft = NSLayoutConstraint.leftToLeft(
            view:viewSelector,
            toView:self)
        NSLayoutConstraint.width(
            view:viewSelector,
            constant:kSelectorWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainSelector:CGFloat = width - kSelectorWidth
        let selectorLeft:CGFloat = remainSelector / 2.0
        layoutSelectorLeft.constant = selectorLeft
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
}
