import UIKit

class VGridVirus:VView
{
    private weak var controller:CGridVirus!
    private weak var layoutLandingTop:NSLayoutConstraint!
    private weak var layoutLandingHeight:NSLayoutConstraint!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CGridVirus
        
        
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        
        super.layoutSubviews()
    }
}
