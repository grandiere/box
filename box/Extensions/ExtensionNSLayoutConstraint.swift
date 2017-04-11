import UIKit

extension NSLayoutConstraint
{
    @discardableResult class func topToTop(
        view:UIView,
        toView:UIView,
        constant:CGFloat = 0,
        multiplier:CGFloat = 1) -> NSLayoutConstraint
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(
            item:view,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:toView,
            attribute:NSLayoutAttribute.top,
            multiplier:multiplier,
            constant:constant)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult class func topToBottom(
        view:UIView,
        toView:UIView,
        constant:CGFloat = 0,
        multiplier:CGFloat = 1) -> NSLayoutConstraint
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(
            item:view,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:toView,
            attribute:NSLayoutAttribute.bottom,
            multiplier:multiplier,
            constant:constant)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult class func bottomToBottom(
        view:UIView,
        toView:UIView,
        constant:CGFloat = 0,
        multiplier:CGFloat = 1) -> NSLayoutConstraint
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(
            item:view,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:toView,
            attribute:NSLayoutAttribute.bottom,
            multiplier:multiplier,
            constant:constant)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult class func bottomToTop(
        view:UIView,
        toView:UIView,
        constant:CGFloat = 0,
        multiplier:CGFloat = 1) -> NSLayoutConstraint
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(
            item:view,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:toView,
            attribute:NSLayoutAttribute.top,
            multiplier:multiplier,
            constant:constant)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult class func leftToLeft(
        view:UIView,
        toView:UIView,
        constant:CGFloat = 0,
        multiplier:CGFloat = 1) -> NSLayoutConstraint
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(
            item:view,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:toView,
            attribute:NSLayoutAttribute.left,
            multiplier:multiplier,
            constant:constant)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult class func leftToRight(
        view:UIView,
        toView:UIView,
        constant:CGFloat = 0,
        multiplier:CGFloat = 1) -> NSLayoutConstraint
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(
            item:view,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:toView,
            attribute:NSLayoutAttribute.right,
            multiplier:multiplier,
            constant:constant)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult class func rightToRight(
        view:UIView,
        toView:UIView,
        constant:CGFloat = 0,
        multiplier:CGFloat = 1) -> NSLayoutConstraint
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(
            item:view,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:toView,
            attribute:NSLayoutAttribute.right,
            multiplier:multiplier,
            constant:constant)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult class func rightToLeft(
        view:UIView,
        toView:UIView,
        constant:CGFloat = 0,
        multiplier:CGFloat = 1) -> NSLayoutConstraint
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(
            item:view,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:toView,
            attribute:NSLayoutAttribute.left,
            multiplier:multiplier,
            constant:constant)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult class func width(
        view:UIView,
        constant:CGFloat = 0,
        multiplier:CGFloat = 1) -> NSLayoutConstraint
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(
            item:view,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:multiplier,
            constant:constant)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult class func height(
        view:UIView,
        constant:CGFloat = 0,
        multiplier:CGFloat = 1) -> NSLayoutConstraint
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(
            item:view,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:multiplier,
            constant:constant)
        constraint.isActive = true
        
        return constraint
    }
    
    class func size(
        view:UIView,
        constant:CGFloat,
        multiplier:CGFloat = 1)
    {
        NSLayoutConstraint.width(
            view:view,
            constant:constant,
            multiplier:multiplier)
        NSLayoutConstraint.height(
            view:view,
            constant:constant,
            multiplier:multiplier)
    }
    
    @discardableResult class func width(
        view:UIView,
        toView:UIView,
        multiplier:CGFloat = 1) -> NSLayoutConstraint
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(
            item:view,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:toView,
            attribute:NSLayoutAttribute.width,
            multiplier:multiplier,
            constant:0)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult class func height(
        view:UIView,
        toView:UIView,
        multiplier:CGFloat = 1) -> NSLayoutConstraint
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(
            item:view,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:toView,
            attribute:NSLayoutAttribute.height,
            multiplier:multiplier,
            constant:0)
        constraint.isActive = true
        
        return constraint
    }
    
    class func equals(view:UIView, toView:UIView, margin:CGFloat = 0)
    {
        NSLayoutConstraint.topToTop(
            view:view,
            toView:toView,
            constant:margin)
        NSLayoutConstraint.bottomToBottom(
            view:view,
            toView:toView,
            constant:-margin)
        NSLayoutConstraint.leftToLeft(
            view:view,
            toView:toView,
            constant:margin)
        NSLayoutConstraint.rightToRight(
            view:view,
            toView:toView,
            constant:-margin)
    }
    
    class func equalsHorizontal(view:UIView, toView:UIView, margin:CGFloat = 0)
    {
        NSLayoutConstraint.leftToLeft(
            view:view,
            toView:toView,
            constant:margin)
        NSLayoutConstraint.rightToRight(
            view:view,
            toView:toView,
            constant:-margin)
    }
    class func equalsVertical(view:UIView, toView:UIView, margin:CGFloat = 0)
    {
        NSLayoutConstraint.topToTop(
            view:view,
            toView:toView,
            constant:margin)
        NSLayoutConstraint.bottomToBottom(
            view:view,
            toView:toView,
            constant:-margin)
    }
}
