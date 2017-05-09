import UIKit

class VStore:VView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CStore!
    private weak var spinner:VSpinner?
    private weak var collectionView:VCollection!
    private let kHeaderHeight:CGFloat = 140
    private let kFooterHeight:CGFloat = 80
    private let kInterLine:CGFloat = 1
    private let kCollectionTop:CGFloat = 70
    private let kCollectionBottom:CGFloat = 20
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor(white:0.96, alpha:1)
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
        collectionView.registerFooter(footer:VStoreFooter.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.headerReferenceSize = CGSize(width:0, height:kHeaderHeight)
            flow.minimumLineSpacing = kInterLine
            flow.sectionInset = UIEdgeInsets(
                top:kInterLine,
                left:0,
                bottom:kCollectionBottom,
                right:0)
        }
        
        addSubview(collectionView)
        addSubview(spinner)
        addSubview(viewBar)
        
        NSLayoutConstraint.topToTop(
            view:collectionView,
            toView:self,
            constant:kCollectionTop)
        NSLayoutConstraint.bottomToBottom(
            view:collectionView,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:collectionView,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.topToTop(
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
    
    override func layoutSubviews()
    {
        collectionView.collectionViewLayout.invalidateLayout()
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MStoreItem
    {
        let itemId:MStore.PurchaseId = controller.model.references[index.section]
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
            
            VAlert.message(message:errorMessage)
        }
    }
    
    //MARK: collection delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, referenceSizeForFooterInSection section:Int) -> CGSize
    {
        let indexPath:IndexPath = IndexPath(item:0, section:section)
        let item:MStoreItem = modelAtIndex(index:indexPath)
        let size:CGSize
        
        if item.status?.restorable == true
        {
            size = CGSize(width:0, height:kFooterHeight)
        }
        else
        {
            size = CGSize.zero
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
        let count:Int = controller.model.references.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let indexPath:IndexPath = IndexPath(item:0, section:section)
        let item:MStoreItem = modelAtIndex(index:indexPath)
        let count:Int
        
        if item.status == nil
        {
            count = 0
        }
        else
        {
            count = 1
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        let reusable:UICollectionReusableView
        
        if kind == UICollectionElementKindSectionHeader
        {
            let item:MStoreItem = modelAtIndex(index:indexPath)
            let header:VStoreHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind:kind,
                withReuseIdentifier:
                VStoreHeader.reusableIdentifier,
                for:indexPath) as! VStoreHeader
            header.config(model:item)
            reusable = header
        }
        else
        {
            let footer:VStoreFooter = collectionView.dequeueReusableSupplementaryView(
                ofKind:kind,
                withReuseIdentifier:
                VStoreFooter.reusableIdentifier,
                for:indexPath) as! VStoreFooter
            footer.config(controller:controller)
            
            reusable = footer
        }
        
        return reusable
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
