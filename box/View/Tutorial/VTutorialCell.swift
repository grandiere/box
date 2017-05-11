import UIKit

class VTutorialCell:UICollectionViewCell
{
    private weak var label:UILabel!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let label:UILabel = UILabel()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(model:MTutorialProtocol)
    {
        
    }
}
