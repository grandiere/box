import UIKit

class VGridVisorDetailCellCreated:VGridVisorDetailCell
{
    private weak var labelCreated:UILabel!
    private let kLabelLeft:CGFloat = 10
    private let kLabelRight:CGFloat = -25
    private let kLabelWidth:CGFloat = 240
    
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
        labelTitle.text = NSLocalizedString("VGridVisorDetailCellCreated_labelTitle", comment:"")
        
        let labelCreated:UILabel = UILabel()
        labelCreated.translatesAutoresizingMaskIntoConstraints = false
        labelCreated.isUserInteractionEnabled = false
        labelCreated.backgroundColor = UIColor.clear
        labelCreated.textAlignment = NSTextAlignment.right
        labelCreated.font = UIFont.numeric(size:16)
        labelCreated.textColor = UIColor.black
        self.labelCreated = labelCreated
        
        addSubview(labelTitle)
        addSubview(labelCreated)
        
        NSLayoutConstraint.equalsVertical(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:labelTitle,
            toView:self,
            constant:kLabelLeft)
        NSLayoutConstraint.width(
            view:labelTitle,
            constant:kLabelWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:labelCreated,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:labelCreated,
            toView:self,
            constant:kLabelRight)
        NSLayoutConstraint.width(
            view:labelCreated,
            constant:kLabelWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(controller:CGridVisorDetail, model:MGridVisorDetailProtocol)
    {
        super.config(controller:controller, model:model)
        
        guard
            
            let modelCreated:MGridVisorDetailItemCreated = model as? MGridVisorDetailItemCreated
            
        else
        {
            return
        }
        
        labelCreated.text = modelCreated.created
    }
}
