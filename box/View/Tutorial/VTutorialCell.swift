import UIKit

class VTutorialCell:UICollectionViewCell
{
    private weak var label:UILabel!
    private let kBorderHeight:CGFloat = 1
    private let kLabelLeft:CGFloat = 10
    private let kLabelWidth:CGFloat = 300
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        
        let border:VBorder = VBorder(color:UIColor(white:1, alpha:0.4))
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.bold(size:14)
        label.textColor = UIColor(white:1, alpha:1)
        self.label = label
        
        addSubview(border)
        addSubview(label)
        
        NSLayoutConstraint.equalsVertical(
            view:label,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:label,
            toView:self,
            constant:kLabelLeft)
        NSLayoutConstraint.width(
            view:label,
            constant:kLabelWidth)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            backgroundColor = UIColor(white:1, alpha:0.3)
        }
        else
        {
            backgroundColor = UIColor.clear
        }
    }
    
    //MARK: public
    
    func config(model:MTutorialProtocol)
    {
        label.text = model.name
        hover()
    }
}
