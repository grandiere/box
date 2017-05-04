import UIKit

class VGridVirus:VView
{
    private weak var controller:CGridVirus!
    private weak var viewReleased:VGridVirusReleased!
    private weak var layoutLandingTop:NSLayoutConstraint!
    private weak var layoutLandingHeight:NSLayoutConstraint!
    private let kAnimationDuration:TimeInterval = 0.3
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CGridVirus
        
        let viewLanding:VGridVirusLanding = VGridVirusLanding(
            controller:self.controller)
        
        let viewReleased:VGridVirusReleased = VGridVirusReleased(
            controller:self.controller)
        self.viewReleased = viewReleased
        
        addSubview(viewLanding)
        addSubview(viewReleased)
        
        layoutLandingTop = NSLayoutConstraint.topToTop(
            view:viewLanding,
            toView:self)
        layoutLandingHeight = NSLayoutConstraint.height(
            view:viewLanding)
        NSLayoutConstraint.equalsHorizontal(
            view:viewLanding,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewReleased,
            toView:viewLanding)
        NSLayoutConstraint.bottomToBottom(
            view:viewReleased,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:viewReleased,
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
    
    func animateRelease(virusDescription:NSAttributedString)
    {
        viewReleased.label.attributedText = virusDescription
        layoutLandingTop.constant = -layoutLandingHeight.constant
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
}
