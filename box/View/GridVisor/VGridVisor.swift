import UIKit

class VGridVisor:VView
{
    private(set) weak var viewMetal:VGridVisorMetal?
    private(set) weak var viewBar:VGridVisorBar!
    private(set) weak var viewMenu:VGridVisorMenu!
    private weak var spinner:VSpinner?
    private weak var controller:CGridVisor!
    private weak var previewLayer:CALayer?
    private let kBarHeight:CGFloat = 70
    private let kMenuHeight:CGFloat = 100
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CGridVisor
        
        if let viewMetal:VGridVisorMetal = VGridVisorMetal(
            controller:self.controller)
        {
            viewMetal.isHidden = true
            self.viewMetal = viewMetal
            
            addSubview(viewMetal)
            
            NSLayoutConstraint.equals(
                view:viewMetal,
                toView:self)
        }
        else
        {
            let error:String = NSLocalizedString("VGridVisor_errorMetal", comment:"")
            VAlert.messageOrange(message:error)
        }
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let viewBar:VGridVisorBar = VGridVisorBar(
            controller:self.controller)
        self.viewBar = viewBar
        
        let viewMenu:VGridVisorMenu = VGridVisorMenu(
            controller:self.controller)
        self.viewMenu = viewMenu
        
        addSubview(spinner)
        addSubview(viewBar)
        addSubview(viewMenu)
        
        NSLayoutConstraint.topToBottom(
            view:spinner,
            toView:viewBar)
        NSLayoutConstraint.bottomToBottom(
            view:spinner,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewMenu,
            toView:self)
        NSLayoutConstraint.height(
            view:viewMenu,
            constant:kMenuHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewMenu,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        spinner?.stopAnimating()
    }
    
    //MARK: public
    
    func showMetal()
    {
        spinner?.stopAnimating()
        spinner?.removeFromSuperview()
        viewMetal?.isHidden = false
    }
    
    func addPreviewLayer(previewLayer:CALayer)
    {
        self.previewLayer = previewLayer
        layer.addSublayer(previewLayer)
    }
}
