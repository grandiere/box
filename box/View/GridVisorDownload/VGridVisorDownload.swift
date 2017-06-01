import UIKit

class VGridVisorDownload:VView
{
    private weak var controller:CGridVisorDownload!
    private weak var viewBase:VGridVisorDownloadBase!
    private weak var layoutBaseTop:NSLayoutConstraint!
    private weak var layoutBaseLeft:NSLayoutConstraint!
    private let kBaseSize:CGFloat = 160
    private let kAnimationDuration:TimeInterval = 1
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CGridVisorDownload
        
        let viewBase:VGridVisorDownloadBase = VGridVisorDownloadBase()
        viewBase.layer.cornerRadius = kBaseSize / 2.0
        self.viewBase = viewBase
        
        addSubview(viewBase)
        
        layoutBaseTop = NSLayoutConstraint.topToTop(
            view:viewBase,
            toView:self)
        layoutBaseLeft = NSLayoutConstraint.leftToLeft(
            view:viewBase,
            toView:self)
        NSLayoutConstraint.size(
            view:viewBase,
            constant:kBaseSize)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let remainWidth:CGFloat = width - kBaseSize
        let remainHeight:CGFloat = height - kBaseSize
        let marginLeft:CGFloat = remainWidth / 2.0
        let marginTop:CGFloat = remainHeight / 2.0
        layoutBaseTop.constant = marginTop
        layoutBaseLeft.constant = marginLeft
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func downloaded(model:MGridVisorDownloadProtocol)
    {
        viewBase.downloadedReady(model:model)
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.viewBase.downloadedAnimation()
        }
    }
}
