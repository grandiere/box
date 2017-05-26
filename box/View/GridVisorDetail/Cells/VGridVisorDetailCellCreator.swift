import UIKit

class VGridVisorDetailCellCreator:VGridVisorDetailCell
{
    private weak var labelCreator:UILabel!
    private weak var layoutIconLeft:NSLayoutConstraint!
    private let kIconWidth:CGFloat = 36
    private let kIconRight:CGFloat = 10
    private let kLabelWidth:CGFloat = 160
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let labelCreator:UILabel = UILabel()
        labelCreator.translatesAutoresizingMaskIntoConstraints = false
        labelCreator.isUserInteractionEnabled = false
        labelCreator.backgroundColor = UIColor.clear
        labelCreator.font = UIFont.regular(size:16)
        labelCreator.textColor = UIColor.black
        labelCreator.textAlignment = NSTextAlignment.right
        self.labelCreator = labelCreator
        
        let icon:UIImageView = UIImageView()
        icon.isUserInteractionEnabled = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.clipsToBounds = true
        icon.contentMode = UIViewContentMode.center
        icon.image = #imageLiteral(resourceName: "assetGenericCreator")
        
        addSubview(labelCreator)
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
            view:labelCreator,
            toView:self)
        NSLayoutConstraint.rightToLeft(
            view:labelCreator,
            toView:icon)
        NSLayoutConstraint.width(
            view:labelCreator,
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
            
            let modelKills:MGridVisorDetailKills = model as? MGridVisorDetailKills
            
        else
        {
            return
        }
    }
}
