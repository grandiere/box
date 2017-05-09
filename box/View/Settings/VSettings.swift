import UIKit

class VSettings:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CSettings!
    private weak var collectionView:VCollection!
    private let kHeaderHeight:CGFloat = 240
    private let kCollectionBottom:CGFloat = 20
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        clipsToBounds = true
        self.controller = controller as? CSettings
        
        let collectionView:VCollection = VCollection()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VSettingsCell.self)
        collectionView.registerHeader(header:VSettingsHeader.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.headerReferenceSize = CGSize(width:0, height:kHeaderHeight)
        }
        
        addSubview(collectionView)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        return 0
    }
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        let header:VSettingsHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind:kind,
            withReuseIdentifier:
            VSettingsHeader.reusableIdentifier,
            for:indexPath) as! VSettingsHeader
        header.config(controller:controller)
        
        return header
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let cell:VSettingsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VSettingsCell.reusableIdentifier,
            for:indexPath) as! VSettingsCell
        
        return cell
    }
}
