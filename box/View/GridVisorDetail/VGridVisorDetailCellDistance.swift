import UIKit

class VGridVisorDetailCellDistance:VGridVisorDetailCell
{
    private weak var labelKm:UILabel!
    private weak var labelScore:UILabel!
    private let kTitleLeft:CGFloat = 10
    private let kTitleWidth:CGFloat = 200
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.bold(size:15)
        labelTitle.text = NSLocalizedString("VGridVisorDetailCellDistance_labelTitle", comment:"")
        labelTitle.textColor = UIColor.black
        
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
