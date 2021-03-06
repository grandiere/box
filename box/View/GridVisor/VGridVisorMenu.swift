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
        buttonMatch.addTarget(
            self,
            action:#selector(actionMatch(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonMatch = buttonMatch
        
        let buttonDownload:VGridVisorMenuButton = VGridVisorMenuButton(image:#imageLiteral(resourceName: "assetGenericDownload"))
        buttonDownload.addTarget(
            self,
            action:#selector(actionDownload(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonDownload = buttonDownload
        
        let buttonDetail:VGridVisorMenuButton = VGridVisorMenuButton(image:#imageLiteral(resourceName: "assetGenericDetail"))
        buttonDetail.addTarget(
            self,
            action:#selector(actionDetail(sender:)),
            for:UIControlEvents.touchUpInside)
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
    
    //MARK: actions
    
    func actionMatch(sender button:VGridVirusOptionsButton)
    {
        guard
            
            let algoHostileItem:MGridAlgoHostileItem = controller.targeting as? MGridAlgoHostileItem
            
        else
        {
            return
        }
        
        if algoHostileItem.showMatch
        {
            controller.showAlgoMatch(item:algoHostileItem)
        }
    }
    
    func actionDetail(sender button:VGridVirusOptionsButton)
    {
        guard
            
            let algoItem:MGridAlgoItem = controller.targeting
            
        else
        {
            return
        }
        
        if algoItem.showDetail
        {
            controller.showAlgoDetail(item:algoItem)
        }
    }
    
    func actionDownload(sender button:VGridVirusOptionsButton)
    {
        guard
            
            let algoAidItem:MGridAlgoAidItem = controller.targeting as? MGridAlgoAidItem
            
        else
        {
            return
        }
        
        if algoAidItem.showDownload
        {
            controller.showAlgoDownload(item:algoAidItem)
        }
    }
    
    //MARK: private
    
    private func hideAll()
    {
        buttonMatch.animate(show:false)
        buttonDetail.animate(show:false)
        buttonDownload.animate(show:false)
    }
    
    private func showOptions()
    {
        guard
        
            let itemAlgo:MGridAlgoItem = self.itemAlgo
        
        else
        {
            return
        }
        
        buttonMatch.animate(show:itemAlgo.showMatch)
        buttonDetail.animate(show:itemAlgo.showDetail)
        buttonDownload.animate(show:itemAlgo.showDownload)
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
                
                DispatchQueue.main.async
                { [weak self] in
                    
                    self?.showOptions()
                }
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
