import UIKit

class VGridVisorBar:UIView
{
    private(set) weak var viewEnergy:VGridVisorBarEnergy!
    private(set) weak var viewRange:VGridVisorBarRange!
    private weak var viewBack:VGridVisorBarBack!
    private weak var controller:CGridVisor!
    private let kBackSize:CGFloat = 70
    private let kEnergyWidth:CGFloat = 160
    private let kRangeWidth:CGFloat = 75
    private let kRangeLeft:CGFloat = -5
    
    init(controller:CGridVisor)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let viewBack:VGridVisorBarBack = VGridVisorBarBack(
            controller:self.controller)
        self.viewBack = viewBack
        
        let viewRange:VGridVisorBarRange = VGridVisorBarRange(
            controller:self.controller)
        self.viewRange = viewRange
        
        let viewEnergy:VGridVisorBarEnergy = VGridVisorBarEnergy(
            controller:controller)
        self.viewEnergy = viewEnergy
        
        addSubview(viewRange)
        addSubview(viewEnergy)
        addSubview(viewBack)
        
        NSLayoutConstraint.topToTop(
            view:viewBack,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:viewBack,
            toView:self)
        NSLayoutConstraint.size(
            view:viewBack,
            constant:kBackSize)
        
        NSLayoutConstraint.equalsVertical(
            view:viewRange,
            toView:viewBack)
        NSLayoutConstraint.leftToRight(
            view:viewRange,
            toView:viewBack,
            constant:kRangeLeft)
        NSLayoutConstraint.width(
            view:viewRange,
            constant:kRangeWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:viewEnergy,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:viewEnergy,
            toView:self)
        NSLayoutConstraint.width(
            view:viewEnergy,
            constant:kEnergyWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
