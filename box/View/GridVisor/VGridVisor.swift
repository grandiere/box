import UIKit

class VGridVisor:VView
{
    private(set) weak var viewMetal:VGridVisorMetal?
    private(set) weak var viewBar:VGridVisorBar!
    private weak var spinner:VSpinner?
    private weak var controller:CGridVisor!
    private weak var previewLayer:CALayer?
    private let kBarHeight:CGFloat = 50
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CGridVisor
        
        guard
            
            let viewMetal:VGridVisorMetal = VGridVisorMetal(
                controller:self.controller)
            
        else
        {
            let error:String = NSLocalizedString("VGridVisor_errorMetal", comment:"")
            VAlert.message(message:error)
            
            return
        }
        
        viewMetal.isHidden = true
        self.viewMetal = viewMetal
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let viewBar:VGridVisorBar = VGridVisorBar(
            controller:self.controller)
        self.viewBar = viewBar
        
        addSubview(viewMetal)
        addSubview(spinner)
        addSubview(viewBar)
        
        NSLayoutConstraint.equals(
            view:viewMetal,
            toView:self)
        
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
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        previewLayer?.frame = bounds
        
        super.layoutSubviews()
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
