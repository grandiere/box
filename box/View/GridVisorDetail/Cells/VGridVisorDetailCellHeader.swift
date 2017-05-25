import UIKit

class VGridVisorDetailCellHeader:VGridVisorDetailCell
{
    private weak var imageView:UIImageView!
    private weak var labelTitle:UILabel!
    private let kImageHeight:CGFloat = 180
    private let kTitleHeight:CGFloat = 120
    private let kCloseSize:CGFloat = 60
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let finder:UIImageView = UIImageView()
        finder.isUserInteractionEnabled = false
        finder.translatesAutoresizingMaskIntoConstraints = false
        finder.contentMode = UIViewContentMode.center
        finder.clipsToBounds = true
        finder.image = #imageLiteral(resourceName: "assetGenericFinder")
        
        let imageView:UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.isUserInteractionEnabled = false
        self.imageView = imageView
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.bold(size:14)
        labelTitle.textColor = UIColor.black
        labelTitle.textAlignment = NSTextAlignment.center
        self.labelTitle = labelTitle
        
        let buttonClose:UIButton = UIButton()
        buttonClose.translatesAutoresizingMaskIntoConstraints = false
        buttonClose.setImage(
            #imageLiteral(resourceName: "assetGenericClose").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonClose.setImage(
            #imageLiteral(resourceName: "assetGenericClose").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonClose.imageView!.contentMode = UIViewContentMode.center
        buttonClose.imageView!.clipsToBounds = true
        buttonClose.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        buttonClose.addTarget(
            self,
            action:#selector(actionClose(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(finder)
        addSubview(imageView)
        addSubview(labelTitle)
        addSubview(buttonClose)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        NSLayoutConstraint.height(
            view:imageView,
            constant:kImageHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:finder,
            toView:imageView)
        
        NSLayoutConstraint.bottomToBottom(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:buttonClose,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:buttonClose,
            toView:self)
        NSLayoutConstraint.size(
            view:buttonClose,
            constant:kCloseSize)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(controller:CGridVisorDetail, model:MGridVisorDetailProtocol)
    {
        super.config(controller:controller, model:model)
        
        guard
        
            let modelHeader:MGridVisorDetailHeader = model as? MGridVisorDetailHeader
        
        else
        {
            return
        }
        
        imageView.image = modelHeader.icon
        labelTitle.text = modelHeader.title
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        controller?.back()
    }
}
