import UIKit

class VCollectionFlow:UICollectionViewFlowLayout
{
    override init()
    {
        super.init()
        headerReferenceSize = CGSize.zero
        footerReferenceSize = CGSize.zero
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        sectionInset = UIEdgeInsets.zero
        scrollDirection = UICollectionViewScrollDirection.vertical
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds:CGRect) -> Bool
    {
        return false
    }
}
