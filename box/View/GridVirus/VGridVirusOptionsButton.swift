import UIKit

class VGridVirusOptionsButton:UIButton
{
    private let kNotActiveAlpha:CGFloat = 0.4
    
    init(color:UIColor, title:String)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = color
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for:UIControlState.normal)
        setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        titleLabel!.font = UIFont.bold(size:14)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func notActive()
    {
        isUserInteractionEnabled = false
        alpha = kNotActiveAlpha
    }
}
