import UIKit

class VGridVisorDetailCellKills:VGridVisorDetailCell
{
    private weak var labelKills:UILabel!
    private weak var layoutIconLeft:NSLayoutConstraint!
    private let kIconWidth:CGFloat = 36
    private let kIconRight:CGFloat = 10
    private let kLabelWidth:CGFloat = 160
    private let kTitleHeight:CGFloat = 52
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let labelKills:UILabel = UILabel()
        labelKills.translatesAutoresizingMaskIntoConstraints = false
        labelKills.isUserInteractionEnabled = false
        labelKills.backgroundColor = UIColor.clear
        labelKills.font = UIFont.numeric(size:24)
        labelKills.textColor = UIColor.black
        labelKills.textAlignment = NSTextAlignment.right
        self.labelKills = labelKills
        
        let labelTitle:UILabel = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.isUserInteractionEnabled = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.regular(size:11)
        labelTitle.textColor = UIColor(white:0.6, alpha:1)
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.text = NSLocalizedString("VGridVisorDetailCellKills_labelTitle", comment:"")
        
        let icon:UIImageView = UIImageView()
        icon.isUserInteractionEnabled = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.clipsToBounds = true
        icon.contentMode = UIViewContentMode.center
        icon.image = #imageLiteral(resourceName: "assetGenericKills")
        
        addSubview(labelTitle)
        addSubview(labelKills)
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
            view:labelKills,
            toView:self)
        NSLayoutConstraint.rightToLeft(
            view:labelKills,
            toView:icon)
        NSLayoutConstraint.width(
            view:labelKills,
            constant:kLabelWidth)
        
        NSLayoutConstraint.bottomToBottom(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
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
        
        let kills:String = "\(modelKills.kills)"
        labelKills.text = kills
    }
}
