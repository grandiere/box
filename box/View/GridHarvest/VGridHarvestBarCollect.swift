import UIKit

class VGridHarvestBarCollect:UIButton
{
    private weak var controller:CGridHarvest!
    private weak var labelAmount:UILabel!
    private weak var labelGet:UILabel!
    private weak var viewGet:UIView!
    private let KBorderWidth:CGFloat = 1
    private let kCornerRadius:CGFloat = 6
    private let kGetWidth:CGFloat = 50
    
    init(controller:CGridHarvest)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = kCornerRadius
        layer.borderWidth = KBorderWidth
        layer.borderColor = UIColor.gridBlue.cgColor
        self.controller = controller
        
        let viewGet:UIView = UIView()
        viewGet.translatesAutoresizingMaskIntoConstraints = false
        viewGet.isUserInteractionEnabled = false
        viewGet.clipsToBounds = true
        self.viewGet = viewGet
        
        let labelGet:UILabel = UILabel()
        labelGet.isUserInteractionEnabled = false
        labelGet.backgroundColor = UIColor.clear
        labelGet.translatesAutoresizingMaskIntoConstraints = false
        labelGet.textAlignment = NSTextAlignment.center
        labelGet.font = UIFont.bold(size:14)
        labelGet.text = NSLocalizedString("VGridHarvestBarCollect_labelGet", comment:"")
        self.labelGet = labelGet
        
        viewGet.addSubview(labelGet)
        addSubview(viewGet)
        
        NSLayoutConstraint.equals(
            view:labelGet,
            toView:viewGet)
        
        NSLayoutConstraint.equalsVertical(
            view:viewGet,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:viewGet,
            toView:self)
        NSLayoutConstraint.width(
            view:viewGet,
            constant:kGetWidth)
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
        if isUserInteractionEnabled
        {
            if isSelected || isHighlighted
            {
                viewGet.backgroundColor = UIColor.gridOrange
                labelGet.textColor = UIColor.white
            }
            else
            {
                viewGet.backgroundColor = UIColor.gridBlue
                labelGet.textColor = UIColor.black
            }
        }
        else
        {
            viewGet.backgroundColor = UIColor(white:1, alpha:0.2)
            labelGet.textColor = UIColor(white:1, alpha:0.6)
        }
    }
}
