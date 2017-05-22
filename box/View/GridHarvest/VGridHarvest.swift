import UIKit

class VGridHarvest:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private(set) weak var viewBar:VGridHarvestBar!
    private weak var controller:CGridHarvest!
    private weak var spinner:VSpinner!
    private weak var collectionView:VCollection!
    private let kBarHeight:CGFloat = 150
    private let kSubbarHeight:CGFloat = 40
    private let kCellHeight:CGFloat = 50
    private let kHeaderHeight:CGFloat = 200
    private let kCollectionBottom:CGFloat = 20
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CGridHarvest
        
        let viewBar:VGridHarvestBar = VGridHarvestBar(controller:self.controller)
        self.viewBar = viewBar
        
        let viewSubbar:VGridHarvestSubbar = VGridHarvestSubbar()
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let collectionView:VCollection = VCollection()
        collectionView.isHidden = true
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VGridHarvestCell.self)
        collectionView.registerHeader(header:VGridHarvestHeader.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.sectionInset = UIEdgeInsets(
                top:kSubbarHeight,
                left:0,
                bottom:kCollectionBottom,
                right:0)
        }
        
        addSubview(viewBar)
        addSubview(collectionView)
        addSubview(viewSubbar)
        addSubview(spinner)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:collectionView,
            toView:viewBar)
        NSLayoutConstraint.bottomToBottom(
            view:collectionView,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:collectionView,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewSubbar,
            toView:viewBar)
        NSLayoutConstraint.height(
            view:viewSubbar,
            constant:kSubbarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewSubbar,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        spinner.stopAnimating()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MGridAlgoItemHostileVirusFriendly
    {
        let item:MGridAlgoItemHostileVirusFriendly = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func refresh()
    {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()
        viewBar.viewCollect.displayHarvest()
    }
    
    func loading()
    {
        spinner.startAnimating()
        collectionView.isHidden = true
    }
    
    //MARK: collectionView delegate

    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, referenceSizeForHeaderInSection section:Int) -> CGSize
    {
        let size:CGSize
        
        if controller.model.items.count > 0
        {
            size = CGSize.zero
        }
        else
        {
            size = CGSize(width:0, height:kHeaderHeight)
        }
        
        return size
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = bounds.maxX
        let size:CGSize = CGSize(width:width, height:kCellHeight)
        
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
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        let header:VGridHarvestHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind:kind,
            withReuseIdentifier:
            VGridHarvestHeader.reusableIdentifier,
            for:indexPath) as! VGridHarvestHeader
        
        return header
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) ->UICollectionViewCell
    {
        let item:MGridAlgoItemHostileVirusFriendly = modelAtIndex(index:indexPath)
        let cell:VGridHarvestCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VGridHarvestCell.reusableIdentifier,
            for:indexPath) as! VGridHarvestCell
        cell.config(virus:item)
        
        if indexPath.item % 2 == 0
        {
            cell.backgroundColor = UIColor.clear
        }
        else
        {
            cell.backgroundColor = UIColor(white:1, alpha:0.1)
        }
        
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
