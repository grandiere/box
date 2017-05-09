import UIKit

class VStoreCell:UICollectionViewCell
{
    weak var controller:CStore?
    weak var model:MStoreItem?
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(controller:CStore, model:MStoreItem)
    {
        self.controller = controller
        self.model = model
    }
}
