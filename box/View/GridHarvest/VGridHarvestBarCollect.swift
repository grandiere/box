import UIKit

class VGridHarvestBarCollect:UIButton
{
    private weak var controller:CGridHarvest!
    private weak var labelAmount:UILabel!
    private weak var labelGet:UILabel!
    private weak var viewGet:UIView!
    private let KBorderWidth:CGFloat = 1
    private let kCornerRadius:CGFloat = 6
    private let kGetWidth:CGFloat = 65
    private let kAmountRight:CGFloat = -5
    
    init(controller:CGridHarvest)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = kCornerRadius
        layer.borderWidth = KBorderWidth
        isUserInteractionEnabled = false
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
        
        let labelAmount:UILabel = UILabel()
        labelAmount.translatesAutoresizingMaskIntoConstraints = false
        labelAmount.isUserInteractionEnabled = false
        labelAmount.backgroundColor = UIColor.clear
        labelAmount.textAlignment = NSTextAlignment.right
        labelAmount.font = UIFont.numeric(size:14)
        self.labelAmount = labelAmount
        
        viewGet.addSubview(labelGet)
        addSubview(viewGet)
        addSubview(labelAmount)
        
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
        
        NSLayoutConstraint.equalsVertical(
            view:labelAmount,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:labelAmount,
            toView:self)
        NSLayoutConstraint.rightToLeft(
            view:labelAmount,
            toView:viewGet,
            constant:kAmountRight)
        
        hover()
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
                layer.borderColor = UIColor.gridOrange.cgColor
                viewGet.backgroundColor = UIColor.gridOrange
                labelGet.textColor = UIColor.white
                labelAmount.textColor = UIColor.gridOrange
            }
            else
            {
                if controller.model.harvestScore > 0
                {
                    layer.borderColor = UIColor.gridBlue.cgColor
                    viewGet.backgroundColor = UIColor.gridBlue
                    labelGet.textColor = UIColor.black
                    labelAmount.textColor = UIColor.white
                }
                else
                {
                    layer.borderColor = UIColor(white:1, alpha:0.2).cgColor
                    viewGet.backgroundColor = UIColor(white:1, alpha:0.2)
                    labelGet.textColor = UIColor(white:1, alpha:0.4)
                    labelAmount.textColor = UIColor(white:1, alpha:0.4)
                }
            }
        }
        else
        {
            layer.borderColor = UIColor(white:1, alpha:0.2).cgColor
            viewGet.backgroundColor = UIColor(white:1, alpha:0.2)
            labelGet.textColor = UIColor(white:1, alpha:0.4)
            labelAmount.textColor = UIColor(white:1, alpha:0.4)
        }
    }
    
    //MARK: public
    
    func displayHarvest()
    {
        labelAmount.text = "\(controller.model.harvestScore)"
        
        hover()
    }
}
