import UIKit

class VGridHarvestBar:UIView
{
    private weak var controller:CGridHarvest!
    private weak var viewCollect:VGridHarvestBarCollect!
    private let kCollectWidth:CGFloat = 140
    private let kButtonWidth:CGFloat = 60
    private let kBorderHeight:CGFloat = 1
    
    init(controller:CGridHarvest)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let viewCollect:VGridHarvestBarCollect = VGridHarvestBarCollect(
            controller:controller)
        self.viewCollect = viewCollect
        
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
        
        let border:VBorder = VBorder(color:UIColor(white:1, alpha:0.3))
        
        addSubview(viewCollect)
        addSubview(backButton)
        addSubview(border)
        
        NSLayoutConstraint.equalsVertical(
            view:viewCollect,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:viewCollect,
            toView:self)
        NSLayoutConstraint.width(
            view:viewCollect,
            constant:kCollectWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:backButton,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:backButton,
            toView:self)
        NSLayoutConstraint.width(
            view:backButton,
            constant:kButtonWidth)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
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
}
