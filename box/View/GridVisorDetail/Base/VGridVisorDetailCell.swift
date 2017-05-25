import UIKit

class VGridVisorDetailCell:UICollectionViewCell
{
    private(set) weak var controller:CGridVisorDetail?
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(controller:CGridVisorDetail, model:MGridVisorDetailProtocol)
    {
        self.controller = controller
    }
}
