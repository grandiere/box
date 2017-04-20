import UIKit

class VGridVisorDetailCell:UICollectionViewCell
{
    private(set) weak var controller:CGridVisorDetail?
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        backgroundColor = UIColor(white:1, alpha:0.5)
        clipsToBounds = true
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(controller:CGridVisorDetail, model:MGridVisorDetailItem)
    {
        self.controller = controller
    }
}
