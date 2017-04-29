import UIKit

class VGridVisorDetail:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CGridVisorDetail!
    private weak var collectionView:VCollection!
    private let kBarHeight:CGFloat = 60
    private let kInterItems:CGFloat = 2
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CGridVisorDetail
        
        let blur:VBlur = VBlur.extraLight()
        
        let viewBar:VGridVisorDetailBar = VGridVisorDetailBar(
            controller:self.controller)
        
        let collectionView:VCollection = VCollection()
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VGridVisorDetailCellHeader.self)
        collectionView.registerCell(cell:VGridVisorDetailCellDistance.self)
        collectionView.registerCell(cell:VGridVisorDetailCellLevel.self)
        collectionView.registerCell(cell:VGridVisorDetailCellMatch.self)
        collectionView.registerCell(cell:VGridVisorDetailCellTake.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.minimumInteritemSpacing = kInterItems
            flow.minimumLineSpacing = kInterItems
        }
        
        addSubview(blur)
        addSubview(collectionView)
        addSubview(viewBar)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MGridVisorDetailItem
    {
        let item:MGridVisorDetailItem = controller.modelDetail.items[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let item:MGridVisorDetailItem = modelAtIndex(index:indexPath)
        let width:CGFloat = collectionView.bounds.maxX
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
        let count:Int = controller.modelDetail.items.count
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let item:MGridVisorDetailItem = modelAtIndex(index:indexPath)
        let cell:VGridVisorDetailCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:item.reusableIdentifier,
            for:indexPath) as! VGridVisorDetailCell
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
