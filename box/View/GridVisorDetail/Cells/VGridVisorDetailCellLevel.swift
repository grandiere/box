import UIKit

class VGridVisorDetailCellLevel:VGridVisorDetailCell
{
    private weak var labelLevel:UILabel!
    private let kLevelTop:CGFloat = -20
    private let kLevelHeight:CGFloat = 65
    private let kTitleHeight:CGFloat = 30
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let labelLevel:UILabel = UILabel()
        labelLevel.translatesAutoresizingMaskIntoConstraints = false
        labelLevel.isUserInteractionEnabled = false
        labelLevel.backgroundColor = UIColor.clear
        labelLevel.font = UIFont.numeric(size:40)
        labelLevel.textColor = UIColor.black
        labelLevel.textAlignment = NSTextAlignment.center
        self.labelLevel = labelLevel
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.font = UIFont.bold(size:15)
        labelTitle.textColor = UIColor.gridBlue
        labelTitle.text = NSLocalizedString("VGridVisorDetailCellLevel_labelTitle", comment:"")
        
        addSubview(labelTitle)
        addSubview(labelLevel)
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)

        NSLayoutConstraint.topToBottom(
            view:labelLevel,
            toView:labelTitle,
            constant:kLevelTop)
        NSLayoutConstraint.height(
            view:labelLevel,
            constant:kLevelHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelLevel,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(controller:CGridVisorDetail, model:MGridVisorDetailProtocol)
    {
        super.config(controller:controller, model:model)
        
        guard
            
            let modelLevel:MGridVisorDetailLevel = model as? MGridVisorDetailLevel
            
            else
        {
            return
        }
        
        labelLevel.text = "\(modelLevel.level)"
    }
}
