import UIKit

class VGridBar:UIView
{
    private weak var controller:CGrid!
    private let kBorderHeight:CGFloat = 1
    
    init(controller:CGrid)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let border:VBorder = VBorder(color:UIColor.gridBlue)
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.bolder(size:17)
        labelTitle.text = NSLocalizedString("VGridBar_labelTitle", comment:"")
        labelTitle.textColor = UIColor.gridBlue
        
        addSubview(border)
        addSubview(labelTitle)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:labelTitle,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
