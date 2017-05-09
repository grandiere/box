import UIKit

class VSettingsCell:UICollectionViewCell
{
    private(set) weak var controller:CSettings?
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(controller:CSettings)
    {
        self.controller = controller
    }
}
