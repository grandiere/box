import UIKit

class VGridVisorDebug:VView
{
    private weak var controller:CGridVisorDebug!
    private weak var spinner:VSpinner!
    private let kLabelTop:CGFloat = 20
    private let kLabelHeight:CGFloat = 26
    private let kImageHeight:CGFloat = 120
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        self.controller = controller as? CGridVisorDebug
        
        let blur:VBlur = VBlur.dark()
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let label:UILabel = UILabel()
        label.font = UIFont.bold(size:20)
        label.textAlignment = NSTextAlignment.center
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.text = NSLocalizedString("VGridVisorDebug_labelTitle", comment:"")
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.image = #imageLiteral(resourceName: "assetGenericDebug")
        
        addSubview(blur)
        addSubview(spinner)
        addSubview(label)
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:imageView,
            toView:label)
        NSLayoutConstraint.height(
            view:imageView,
            constant:kImageHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:spinner,
            toView:imageView)
        NSLayoutConstraint.bottomToBottom(
            view:spinner,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:label,
            toView:self,
            constant:kLabelTop)
        NSLayoutConstraint.height(
            view:label,
            constant:kLabelHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        spinner.stopAnimating()
    }
}
