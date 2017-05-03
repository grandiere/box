import UIKit

class VGridVirusOptionsButton:UIButton
{
    init(color:UIColor, title:String)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = color
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
