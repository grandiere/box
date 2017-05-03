import UIKit

class VGridVirus:VView
{
    private weak var controller:CGridVirus!
    private weak var layoutLandingTop:NSLayoutConstraint!
    private weak var layoutLandingHeight:NSLayoutConstraint!
    private let kAnimationDuration:TimeInterval = 0.3
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CGridVirus
        
        let viewLanding:VGridVirusLanding = VGridVirusLanding(
            controller:self.controller)
        
        addSubview(viewLanding)
        
        layoutLandingTop = NSLayoutConstraint.topToTop(
            view:viewLanding,
            toView:self)
        layoutLandingHeight = NSLayoutConstraint.height(
            view:viewLanding)
        NSLayoutConstraint.equalsHorizontal(
            view:viewLanding,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.maxY
        layoutLandingHeight.constant = height
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func animateRelease()
    {
        layoutLandingTop.constant = -layoutLandingHeight.constant
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
}
