import UIKit

class VGridVisorMenu:UIView
{
    private weak var controller:CGridVisor!
    private weak var buttonMatch:UIButton!
    private let kItemWidth:CGFloat = 90
    private let kBottom:CGFloat = -50
    
    init(controller:CGridVisor)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let buttonMatch:UIButton = UIButton()
        buttonMatch.translatesAutoresizingMaskIntoConstraints = false
        buttonMatch.setImage(
            #imageLiteral(resourceName: "assetGenericMatch").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonMatch.setImage(
            #imageLiteral(resourceName: "assetGenericMatch").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.highlighted)
        buttonMatch.imageView!.clipsToBounds = true
        buttonMatch.imageView!.contentMode = UIViewContentMode.center
        self.buttonMatch = buttonMatch
        
        addSubview(buttonMatch)
        
        NSLayoutConstraint.topToTop(
            view:buttonMatch,
            toView:self)
        NSLayoutConstraint.bottomToBottom(
            view:buttonMatch,
            toView:self,
            constant:kBottom)
        NSLayoutConstraint.leftToLeft(
            view:buttonMatch,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonMatch,
            constant:kItemWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
