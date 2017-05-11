import UIKit

class VTutorial:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CTutorial!
    private weak var collectionView:VCollection!
    private let kBarHeight:CGFloat = 120
    private let kCollectionBottom:CGFloat = 20
    private let kCellHeight:CGFloat = 52
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CTutorial
        
        let viewBar:VTutorialBar = VTutorialBar(
            controller:self.controller)
        
        let collectionView:VCollection = VCollection()
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VTutorialCell.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.sectionInset = UIEdgeInsets(
                top:kBarHeight,
                left:0,
                bottom:kCollectionBottom,
                right:0)
        }
        
        addSubview(collectionView)
        addSubview(viewBar)
        
        NSLayoutConstraint.equals(
            view:collectionView,
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
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MTutorialProtocol
    {
        let item:MTutorialProtocol = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
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
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MTutorialProtocol = modelAtIndex(index:indexPath)
        let cell:VTutorialCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VTutorialCell.reusableIdentifier,
            for:indexPath) as! VTutorialCell
        cell.config(model:item)
        
        return cell
    }
}
