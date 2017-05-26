import UIKit

class VGridVisorDetailCellAge:VGridVisorDetailCell
{
    private weak var labelAge:UILabel!
    private weak var layoutIconLeft:NSLayoutConstraint!
    private let kIconWidth:CGFloat = 36
    private let kIconRight:CGFloat = 10
    private let kLabelWidth:CGFloat = 200
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let labelAge:UILabel = UILabel()
        labelAge.translatesAutoresizingMaskIntoConstraints = false
        labelAge.isUserInteractionEnabled = false
        labelAge.backgroundColor = UIColor.clear
        labelAge.font = UIFont.regular(size:15)
        labelAge.textColor = UIColor.black
        labelAge.textAlignment = NSTextAlignment.right
        self.labelAge = labelAge
        
        let icon:UIImageView = UIImageView()
        icon.isUserInteractionEnabled = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.clipsToBounds = true
        icon.contentMode = UIViewContentMode.center
        icon.image = #imageLiteral(resourceName: "assetGenericCreator")
        
        addSubview(labelAge)
        addSubview(icon)
        
        NSLayoutConstraint.equalsVertical(
            view:icon,
            toView:self)
        layoutIconLeft = NSLayoutConstraint.leftToLeft(
            view:icon,
            toView:self)
        NSLayoutConstraint.width(
            view:icon,
            constant:kIconWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:labelAge,
            toView:self)
        NSLayoutConstraint.rightToLeft(
            view:labelAge,
            toView:icon)
        NSLayoutConstraint.width(
            view:labelAge,
            constant:kLabelWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainLeft:CGFloat = width - kIconWidth
        let marginLeft:CGFloat = remainLeft / 2.0
        layoutIconLeft.constant = marginLeft + kIconRight
        
        super.layoutSubviews()
    }
    
    override func config(controller:CGridVisorDetail, model:MGridVisorDetailProtocol)
    {
        super.config(controller:controller, model:model)
        
        guard
            
            let modelAge:MGridVisorDetailAge = model as? MGridVisorDetailAge
            
        else
        {
            return
        }
        
        labelAge.text = modelAge.age
    }
}
