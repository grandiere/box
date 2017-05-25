import UIKit

class VGridVisorDetailCellKills:VGridVisorDetailCell
{
    private weak var labelKills:UILabel!
    private weak var layoutIconLeft:NSLayoutConstraint!
    private let kIconWidth:CGFloat = 60
    private let kLabelWidth:CGFloat = 200
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let labelKills:UILabel = UILabel()
        labelKills.translatesAutoresizingMaskIntoConstraints = false
        labelKills.isUserInteractionEnabled = false
        labelKills.backgroundColor = UIColor.clear
        labelKills.font = UIFont.numeric(size:30)
        labelKills.textColor = UIColor.black
        self.labelKills = labelKills
        
        addSubview(labelKills)
        
        
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let centerX:CGFloat = bounds.midX
        let centerY:CGFloat = bounds.midY
        layoutLabelTop.constant = centerY
        layoutLabelLeft.constant = centerX - kLabelLeft
        
        super.layoutSubviews()
    }
    
    override func config(controller:CGridVisorDetail, model:MGridVisorDetailProtocol)
    {
        super.config(controller:controller, model:model)
    }
}
