import UIKit

class VGridVisorDetailCellActions:VGridVisorDetailCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewFlowLayout
{
    private weak var collectionView:VCollection!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let collectionView:VCollection = VCollection()
        self.collectionView = collectionView
        
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
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell:vcolle
    }
}
