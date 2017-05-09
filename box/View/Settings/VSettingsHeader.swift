import UIKit

class VSettingsHeader:UICollectionReusableView
{
    private weak var controller:CSettings?
    private let kBackButtonSize:CGFloat = 70
    private let kVersionHeight:CGFloat = 20
    private let kVersionBottom:CGFloat = -50
    private let kVersionKey:String = "CFBundleShortVersionString"
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "assetGenericLogo")
        
        let labelVersion:UILabel = UILabel()
        labelVersion.translatesAutoresizingMaskIntoConstraints = false
        labelVersion.backgroundColor = UIColor.clear
        labelVersion.isUserInteractionEnabled = false
        labelVersion.textAlignment = NSTextAlignment.center
        labelVersion.font = UIFont.regular(size:14)
        labelVersion.textColor = UIColor.white
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        backButton.imageView!.tintColor = UIColor(white:1, alpha:0.2)
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.contentMode = UIViewContentMode.center
        backButton.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(imageView)
        addSubview(backButton)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:backButton,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:backButton,
            toView:self)
        NSLayoutConstraint.size(
            view:backButton,
            constant:kBackButtonSize)
        
        NSLayoutConstraint.bottomToBottom(
            view:labelVersion,
            toView:self,
            constant:kVersionBottom)
        NSLayoutConstraint.height(
            view:labelVersion,
            constant:kVersionHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelVersion,
            toView:self)
        
        guard
            
            let bundleDictionary:[String:Any] = Bundle.main.infoDictionary
            
        else
        {
            return
        }
        
        let versionString:String? = bundleDictionary[kVersionKey] as? String
        labelVersion.text = versionString
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller?.back()
    }
    
    //MARK: public
    
    func config(controller:CSettings)
    {
        self.controller = controller
    }
}
