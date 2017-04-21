import UIKit

class VLanding:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CLanding!
    private weak var viewBar:VLandingBar!
    private weak var collectionView:VCollection!
    private weak var spinner:VSpinner?
    private let kBarHeight:CGFloat = 60
    private let kInterItem:CGFloat = 1
    private let kCollectionBottom:CGFloat = 20
    private let kDeselectTime:TimeInterval = 0.2
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CLanding
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let viewBar:VLandingBar = VLandingBar(
            controller:self.controller)
        viewBar.isHidden = true
        self.viewBar = viewBar
        
        let collectionView:VCollection = VCollection()
        collectionView.isHidden = true
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VLandingCellTheGrid.self)
        collectionView.registerCell(cell:VLandingCellProfile.self)
        collectionView.registerCell(cell:VLandingCellStats.self)
        collectionView.registerCell(cell:VLandingCellBoards.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.minimumLineSpacing = kInterItem
            flow.minimumInteritemSpacing = kInterItem
            flow.sectionInset = UIEdgeInsets(
                top:0,
                left:0,
                bottom:0,
                right:kCollectionBottom)
        }
        
        addSubview(collectionView)
        addSubview(viewBar)
        addSubview(spinner)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        spinner?.stopAnimating()
    }
    
    //MARK: actions
    
    func actionScanner(sender button:UIButton)
    {
        controller.openScanner()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MLandingItem
    {
        let item:MLandingItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func sessionLoaded()
    {
        spinner?.stopAnimating()
        spinner?.removeFromSuperview()
        collectionView.isHidden = false
        viewBar.isHidden = false
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let item:MLandingItem = modelAtIndex(index:indexPath)
        let width:CGFloat = collectionView.bounds.size.width
        let size:CGSize = CGSize(
            width:width,
            height:item.cellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MLandingItem = modelAtIndex(index:indexPath)
        let cell:VLandingCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            item.reusableIdentifier,
            for:indexPath) as! VLandingCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        collectionView.isUserInteractionEnabled = false
        
        let item:MLandingItem = modelAtIndex(index:indexPath)
        item.selected(controller:controller)
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kDeselectTime)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition())
            collectionView?.isUserInteractionEnabled = false
        }
    }
}
