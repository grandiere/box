import UIKit

class VScanner:VView
{
    private(set) weak var viewMetal:VScannerMetal?
    private weak var controller:CScanner!
    private weak var previewLayer:CALayer?
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CScanner
        
        guard
            
            let viewMetal:VScannerMetal = VScannerMetal(
                controller:self.controller)
            
        else
        {
            let error:String = NSLocalizedString("VScanner_errorMetal", comment:"")
            VAlert.message(message:error)
            
            return
        }
        
        self.viewMetal = viewMetal
        
        addSubview(viewMetal)
        
        NSLayoutConstraint.equals(
            view:viewMetal,
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
    
    func addPreviewLayer(previewLayer:CALayer)
    {
        self.previewLayer = previewLayer
        layer.addSublayer(previewLayer)
    }
}
