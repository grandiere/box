import UIKit

class VGridVisor:VView
{
    private(set) weak var viewMetal:VGridVisorMetal?
    private weak var spinner:VSpinner?
    private weak var controller:CGridVisor!
    private weak var previewLayer:CALayer?
    private let kBarHeight:CGFloat = 60
    
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
        
        addSubview(viewMetal)
        addSubview(spinner)
        addSubview(viewBar)
        
        NSLayoutConstraint.equals(
            view:viewMetal,
            toView:self)
        
        NSLayoutConstraint.equals(
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
    }
    
    func addPreviewLayer(previewLayer:CALayer)
    {
        self.previewLayer = previewLayer
        layer.addSublayer(previewLayer)
    }
}
