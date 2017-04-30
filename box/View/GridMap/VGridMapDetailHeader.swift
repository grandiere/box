import UIKit

class VGridMapDetailHeader:UICollectionReusableView
{
    private weak var imageView:UIImageView!
    private let kImageTop:CGFloat = 10
    private let kButtonSize:CGFloat = 60
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        self.imageView = imageView
        
        let buttonClose:UIButton = UIButton()
        buttonClose.translatesAutoresizingMaskIntoConstraints = false
        buttonClose.setImage(
            #imageLiteral(resourceName: "assetGenericClose").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonClose.setImage(
            #imageLiteral(resourceName: "assetGenericClose").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonClose.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        buttonClose.imageView!.clipsToBounds = true
        buttonClose.imageView!.contentMode = UIViewContentMode.center
        buttonClose.addTarget(
            self,
            action:#selector(actionClose(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(imageView)
        addSubview(buttonClose)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self,
            constant:kImageTop)
        NSLayoutConstraint.bottomToBottom(
            view:imageView,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:buttonClose,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:buttonClose,
            toView:self)
        NSLayoutConstraint.size(
            view:buttonClose,
            constant:kButtonSize)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        
    }
    
    //MARK: public
    
    func config(model:MGridMapDetail)
    {
        imageView.image = model.image
    }
}
