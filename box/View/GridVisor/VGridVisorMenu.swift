import UIKit

class VGridVisorMenu:UIView
{
    private weak var itemAlgo:MGridAlgoItem?
    private weak var controller:CGridVisor!
    private weak var buttonMatch:VGridVisorMenuButton!
    private weak var buttonDetail:VGridVisorMenuButton!
    private weak var buttonDownload:VGridVisorMenuButton!
    private weak var layoutMatchLeft:NSLayoutConstraint!
    private var shown:Bool
    private let kItemWidth:CGFloat = 100
    private let kBottom:CGFloat = -50
    
    init(controller:CGridVisor)
    {
        shown = false
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let buttonMatch:VGridVisorMenuButton = VGridVisorMenuButton(image:#imageLiteral(resourceName: "assetGenericMatch"))
        self.buttonMatch = buttonMatch
        
        let buttonDownload:VGridVisorMenuButton = VGridVisorMenuButton(image:#imageLiteral(resourceName: "assetGenericDownload"))
        self.buttonDownload = buttonDownload
        
        let buttonDetail:VGridVisorMenuButton = VGridVisorMenuButton(image:#imageLiteral(resourceName: "assetGenericDetail"))
        self.buttonDetail = buttonDetail
        
        addSubview(buttonDownload)
        addSubview(buttonMatch)
        addSubview(buttonDetail)
        
        NSLayoutConstraint.topToTop(
            view:buttonMatch,
            toView:self)
        NSLayoutConstraint.bottomToBottom(
            view:buttonMatch,
            toView:self,
            constant:kBottom)
        layoutMatchLeft = NSLayoutConstraint.leftToLeft(
            view:buttonMatch,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonMatch,
            constant:kItemWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonDownload,
            toView:buttonMatch)
        NSLayoutConstraint.rightToLeft(
            view:buttonDownload,
            toView:buttonMatch)
        NSLayoutConstraint.width(
            view:buttonDownload,
            constant:kItemWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonDetail,
            toView:buttonMatch)
        NSLayoutConstraint.leftToRight(
            view:buttonDetail,
            toView:buttonMatch)
        NSLayoutConstraint.width(
            view:buttonDetail,
            constant:kItemWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainLeft:CGFloat = width - kItemWidth
        let marginLeft:CGFloat = remainLeft / 2.0
        layoutMatchLeft.constant = marginLeft
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func hideAll()
    {
        buttonMatch.animate(show:false)
        buttonDetail.animate(show:false)
        buttonDownload.animate(show:false)
    }
    
    private func showHostile()
    {
        
    }
    
    private func showFriendly()
    {
        
    }
    
    private func showAid()
    {
        
    }
    
    //MARK: public
    
    func updateMenu()
    {
        if let itemAlgo:MGridAlgoItem = controller.targeting
        {
            shown = true
            
            if itemAlgo !== self.itemAlgo
            {
                self.itemAlgo = itemAlgo
            }
        }
        else
        {
            itemAlgo = nil
            
            if shown
            {
                shown = false
                
                DispatchQueue.main.async
                { [weak self] in
                    
                    self?.hideAll()
                }
            }
        }
    }
}
