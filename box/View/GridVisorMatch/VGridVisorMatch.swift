import UIKit

class VGridVisorMatch:VView
{
    private weak var controller:CGridVisorMatch!
    private weak var layoutBaseTop:NSLayoutConstraint!
    private let kBaseMarginHorizontal:CGFloat = 15
    private let kBaseHeight:CGFloat = 220
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        self.controller = controller as? CGridVisorMatch
        
        let viewBase:VGridVisorMatchBase = VGridVisorMatchBase(
            controller:self.controller)
        
        addSubview(viewBase)
        
        layoutBaseTop = NSLayoutConstraint.topToTop(
            view:viewBase,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBase,
            constant:kBaseHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBase,
            toView:self,
            margin:kBaseMarginHorizontal)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.maxY
        let remainHeight:CGFloat = height - kBaseHeight
        let marginTop:CGFloat = remainHeight / 2.0
        layoutBaseTop.constant = marginTop
        
        super.layoutSubviews()
    }
}
