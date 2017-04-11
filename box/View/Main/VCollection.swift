import UIKit

class VCollection:UICollectionView
{
    convenience init()
    {
        let flow:VCollectionFlow = VCollectionFlow()

        self.init(flow:flow)
    }
    
    init(flow:UICollectionViewLayout)
    {
        super.init(frame:CGRect.zero, collectionViewLayout:flow)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func registerCell(cell:UICollectionViewCell.Type)
    {
        register(
            cell,
            forCellWithReuseIdentifier:cell.reusableIdentifier)
    }
    
    func registerFooter(footer:UICollectionReusableView.Type)
    {
        register(
            footer,
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter,
            withReuseIdentifier:footer.reusableIdentifier)
    }
    
    func registerHeader(header:UICollectionReusableView.Type)
    {
        register(
            header,
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader,
            withReuseIdentifier:header.reusableIdentifier)
    }
}
