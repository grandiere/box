import UIKit

class VGridVisorMatchBaseBackground:UIView
{
    private weak var controller:CGridVisorMatch!
    private let kCornerRadius:CGFloat = 15
    private let kBorderWidth:CGFloat = 1
    private let kTitleTop:CGFloat = 40
    private let kTitleHeight:CGFloat = 30
    private let kNumberHeight:CGFloat = 50
    
    init(controller:CGridVisorMatch)
    {
        super.init(frame:CGRect.zero)
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.borderWidth = kBorderWidth
        layer.borderColor = UIColor(white:1, alpha:0.3).cgColor
        layer.cornerRadius = kCornerRadius
        
        let blur:VBlur = VBlur.light()
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.font = UIFont.bold(size:15)
        labelTitle.textColor = UIColor.black
        labelTitle.text = NSLocalizedString("VGridVisorMatchBaseBackground_labelTitle", comment:"")
        
        let labelNumber:UILabel = UILabel()
        labelNumber.translatesAutoresizingMaskIntoConstraints = false
        labelNumber.backgroundColor = UIColor.clear
        labelNumber.isUserInteractionEnabled = false
        labelNumber.textAlignment = NSTextAlignment.center
        labelNumber.font = UIFont.numeric(size:40)
        labelNumber.textColor = UIColor.black
        
        addSubview(blur)
        addSubview(labelTitle)
        addSubview(labelNumber)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self,
            constant:kTitleTop)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
        
        if let credits:Int = controller.model?.credits
        {
            let creditsString:String = "\(credits)"
            labelNumber.text = creditsString
        }
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
