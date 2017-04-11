import UIKit

class VToast:UIView
{
    private weak var label:UILabel!
    private weak var layoutLabelHeight:NSLayoutConstraint!
    private weak var timer:Timer?
    private let drawingOptions:NSStringDrawingOptions
    private let textMargin2:CGFloat
    private let kToastDuration:TimeInterval = 4
    private let kAnimationDuration:TimeInterval = 0.3
    private let kFontSize:CGFloat = 16
    private let kTextMargin:CGFloat = 20
    private let kBackgroundMargin:CGFloat = -10
    private let kCornerRadius:CGFloat = 20
    private let kMaxHeight:CGFloat = 1000
    
    init(
        message:String,
        color:UIColor,
        textColor:UIColor = UIColor.white)
    {
        textMargin2 = kTextMargin + kTextMargin
        drawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesFontLeading,
            NSStringDrawingOptions.usesLineFragmentOrigin])
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        alpha = 0
        
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.medium(size:kFontSize)]
        let string:NSAttributedString = NSAttributedString(
            string:message,
            attributes:attributes)
        
        let background:UIView = UIView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = color
        background.isUserInteractionEnabled = false
        background.clipsToBounds = true
        background.layer.cornerRadius = kCornerRadius
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = textColor
        label.attributedText = string
        self.label = label
        
        addSubview(background)
        addSubview(label)
        
        NSLayoutConstraint.topToTop(
            view:label,
            toView:self,
            constant:kTextMargin)
        layoutLabelHeight = NSLayoutConstraint.height(
            view:label)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self,
            margin:kTextMargin)
        
        NSLayoutConstraint.equals(
            view:background,
            toView:label,
            margin:kBackgroundMargin)
        
        animateShow()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        timer?.invalidate()
    }
    
    override func layoutSubviews()
    {
        let labelWidth:CGFloat = bounds.maxX - textMargin2
        let maxSize:CGSize = CGSize(width:labelWidth, height:kMaxHeight)
        
        if let labelSize:CGRect = label.attributedText?.boundingRect(
            with:maxSize,
            options:drawingOptions,
            context:nil)
        {
            let labelHeight:CGFloat = ceil(
                labelSize.size.height)
            layoutLabelHeight.constant = labelHeight
        }
        
        super.layoutSubviews()
    }
    
    func timeOut(sender timer:Timer)
    {
        timer.invalidate()
        animateHide()
    }
    
    //MARK: private
    
    private func animateHide()
    {
        UIView.animate(
            withDuration:kAnimationDuration,
        animations:
        { [weak self] in
            
            self?.alpha = 0
        })
        { [weak self] (done:Bool) in
        
            self?.removeFromSuperview()
        }
    }
    
    private func animateShow()
    {
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.alpha = 1
        }
        
        timer = Timer.scheduledTimer(
            timeInterval:kToastDuration,
            target:self,
            selector:#selector(timeOut(sender:)),
            userInfo:nil,
            repeats:false)
    }
}
