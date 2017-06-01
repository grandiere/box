import UIKit

class VGridVisorMatchBaseBackground:UIView
{
    private(set) weak var animation:VGridVisorMatchBaseBackgroundAnimation!
    private weak var controller:CGridVisorMatch!
    private weak var labelTitle:UILabel!
    private weak var labelNumber:UILabel!
    private weak var labelFinish:UILabel!
    private weak var blurLight:VBlur!
    private weak var blurDark:VBlur!
    private let kCornerRadius:CGFloat = 15
    private let kBorderWidth:CGFloat = 1
    private let kTitleTop:CGFloat = 40
    private let kTitleHeight:CGFloat = 30
    private let kNumberHeight:CGFloat = 55
    
    init(controller:CGridVisorMatch)
    {
        let attributesNumber:[String:AnyObject] = [
            NSFontAttributeName:UIFont.numeric(size:48),
            NSForegroundColorAttributeName:UIColor.black]
        let attributesPercent:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:25),
            NSForegroundColorAttributeName:UIColor.black]
        
        super.init(frame:CGRect.zero)
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.borderWidth = kBorderWidth
        layer.borderColor = UIColor(white:1, alpha:0.3).cgColor
        layer.cornerRadius = kCornerRadius
        
        let blurLight:VBlur = VBlur.light()
        self.blurLight = blurLight
        
        let blurDark:VBlur = VBlur.dark()
        blurDark.isHidden = true
        self.blurDark = blurDark
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.font = UIFont.bold(size:15)
        labelTitle.textColor = UIColor.black
        labelTitle.text = NSLocalizedString("VGridVisorMatchBaseBackground_labelTitle", comment:"")
        self.labelTitle = labelTitle
        
        let labelNumber:UILabel = UILabel()
        labelNumber.translatesAutoresizingMaskIntoConstraints = false
        labelNumber.backgroundColor = UIColor.clear
        labelNumber.isUserInteractionEnabled = false
        labelNumber.textAlignment = NSTextAlignment.center
        self.labelNumber = labelNumber
        
        let labelFinish:UILabel = UILabel()
        labelFinish.translatesAutoresizingMaskIntoConstraints = false
        labelFinish.isUserInteractionEnabled = false
        labelFinish.backgroundColor = UIColor.clear
        labelFinish.textAlignment = NSTextAlignment.center
        labelFinish.font = UIFont.bold(size:18)
        labelFinish.textColor = UIColor.black
        self.labelFinish = labelFinish
        
        let animation:VGridVisorMatchBaseBackgroundAnimation = VGridVisorMatchBaseBackgroundAnimation()
        animation.isHidden = true
        self.animation = animation
        
        addSubview(blurLight)
        addSubview(blurDark)
        addSubview(labelTitle)
        addSubview(labelNumber)
        addSubview(labelFinish)
        addSubview(animation)
        
        NSLayoutConstraint.equals(
            view:animation,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:blurLight,
            toView:self)

        NSLayoutConstraint.equals(
            view:blurDark,
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
        
        NSLayoutConstraint.topToBottom(
            view:labelNumber,
            toView:labelTitle)
        NSLayoutConstraint.height(
            view:labelNumber,
            constant:kNumberHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelNumber,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:labelFinish,
            toView:self)
        
        if let credits:Int = controller.model?.credits
        {
            let creditsString:String = "\(credits)"
            
            let stringNumber:NSAttributedString = NSAttributedString(
                string:creditsString,
                attributes:attributesNumber)
            let stringPercent:NSAttributedString = NSAttributedString(
                string:"%",
                attributes:attributesPercent)
            let mutableString:NSMutableAttributedString = NSMutableAttributedString()
            mutableString.append(stringNumber)
            mutableString.append(stringPercent)
            
            labelNumber.attributedText = mutableString
        }
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func matchFinished(message:String)
    {
        animation.isHidden = true
        blurLight.isHidden = true
        blurDark.isHidden = true
        labelFinish.text = message
    }
    
    //MARK: public
    
    func animate()
    {
        animation.isHidden = false
        labelTitle.isHidden = true
        labelNumber.isHidden = true
        blurLight.isHidden = true
        blurDark.isHidden = false
    }
    
    func success(message:String)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.backgroundColor = UIColor.gridBlue
            self?.matchFinished(message:message)
        }
    }
    
    func fail(message:String)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.backgroundColor = UIColor.gridOrange
            self?.matchFinished(message:message)
        }
    }
}
