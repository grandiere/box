import UIKit

class VGridVisorDetailCellLevel:VGridVisorDetailCell
{
    private let kTitleLeft:CGFloat = 10
    private let kTitleWidth:CGFloat = 240
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.bold(size:16)
        labelTitle.textColor = UIColor.black
        labelTitle.text = NSLocalizedString("VGridVisorDetailCellLevel_labelTitle", comment:"")
        
        addSubview(labelTitle)
        
        NSLayoutConstraint.equalsVertical(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:labelTitle,
            toView:self,
            constant:kTitleLeft)
        NSLayoutConstraint.width(
            view:labelTitle,
            constant:kTitleWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
