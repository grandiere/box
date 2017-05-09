import UIKit

class VStore:VView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CStore!
    private weak var spinner:VSpinner?
    private weak var collectionView:VCollection!
    private weak var layoutBarTop:NSLayoutConstraint!
    private let kHeaderHeight:CGFloat = 130
    private let kInterLine:CGFloat = 1
    private let kCollectionTop:CGFloat = 120
    private let kCollectionBottom:CGFloat = 70
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CStore
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let viewBar:VStoreBar = VStoreBar(
            controller:self.controller)
        
        let collectionView:VCollection = VCollection()
        collectionView.isHidden = true
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VStoreCellNotAvailable.self)
        collectionView.registerCell(cell:VStoreCellDeferred.self)
        collectionView.registerCell(cell:VStoreCellNew.self)
        collectionView.registerCell(cell:VStoreCellPurchased.self)
        collectionView.registerCell(cell:VStoreCellPurchasing.self)
        collectionView.registerHeader(header:VStoreHeader.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.minimumLineSpacing = kInterLine
        }
        
        addSubview(collectionView)
        addSubview(spinner)
        addSubview(viewBar)
        
        NSLayoutConstraint.topToTop(
            view:collectionView,
            toView:self)
        NSLayoutConstraint.bottomToBottom(
            view:collectionView,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:collectionView,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        
        layoutBarTop = NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kCollectionTop)
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
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MStoreItem
    {
        let itemId:String = controller.model.references[index.section - 1]
        let item:MStoreItem = controller.model.mapItems[itemId]!
        
        return item
    }
    
    //MARK: public
    
    func refreshStore()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.spinner?.removeFromSuperview()
            self?.collectionView.reloadData()
            self?.collectionView.isHidden = false
            
            guard
                
                let errorMessage:String = self?.controller.model.error
                
            else
            {
                return
            }
            
            VAlert.messageOrange(message:errorMessage)
        }
    }
    
    //MARK: collectionView delegate
    
    func scrollViewDidScroll(_ scrollView:UIScrollView)
    {
        var yOffset:CGFloat = scrollView.contentOffset.y
        
        if yOffset < 0
        {
            yOffset = 0
        }
        
        layoutBarTop.constant = yOffset / -3.0
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section:Int) -> UIEdgeInsets
    {
        let top:CGFloat
        let bottom:CGFloat
        
        if section == 0
        {
            top = kCollectionTop
            bottom = 0
        }
        else
        {
            top = 0
            bottom = kCollectionBottom
        }
        
        let insets:UIEdgeInsets = UIEdgeInsets(
            top:top,
            left:0,
            bottom:bottom,
            right:0)
        
        return insets
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, referenceSizeForHeaderInSection section:Int) -> CGSize
    {
        let size:CGSize
        
        if section == 0
        {
            size = CGSize.zero
        }
        else
        {
            size = CGSize(width:0, height:kHeaderHeight)
        }
        
        return size
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let item:MStoreItem = modelAtIndex(index:indexPath)
        let cellHeight:CGFloat = item.status!.cellHeight
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(width:width, height:cellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        let count:Int = controller.model.references.count + 1
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int
        
        if section == 0
        {
            count = 0
        }
        else
        {
            let indexPath:IndexPath = IndexPath(item:0, section:section)
            let item:MStoreItem = modelAtIndex(index:indexPath)
            
            if item.status == nil
            {
                count = 0
            }
            else
            {
                count = 1
            }
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        let item:MStoreItem = modelAtIndex(index:indexPath)
        let header:VStoreHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind:kind,
            withReuseIdentifier:
            VStoreHeader.reusableIdentifier,
            for:indexPath) as! VStoreHeader
        header.config(model:item)
        
        return header
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MStoreItem = modelAtIndex(index:indexPath)
        let reusableIdentifier:String = item.status!.reusableIdentifier
        
        let cell:VStoreCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            reusableIdentifier,
            for:indexPath) as! VStoreCell
        cell.config(controller:controller, model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
}
