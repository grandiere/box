import UIKit

class VAlert:UIView
{
    static let kMarginHorizontal:CGFloat = 5
    static let kHeight:CGFloat = 70
    private weak var layoutTop:NSLayoutConstraint!
    private weak var timer:Timer?
    private let kMarginTop:CGFloat = 20
    private let kAnimationDuration:TimeInterval = 0.2
    private let kTimeOut:TimeInterval = 4
    private let kFontSize:CGFloat = 15
    private let kLabelMargin:CGFloat = 10
    private let kCornerRadius:CGFloat = 12
    private let kBorderWidth:CGFloat = 0.5
    
    class func message(message:String)
    {
        DispatchQueue.main.async
        {
            let alert:VAlert = VAlert(
                message:message)
            
            let rootView:UIView = UIApplication.shared.keyWindow!.rootViewController!.view
            rootView.addSubview(alert)
            
            alert.layoutTop = NSLayoutConstraint.topToTop(
                view:alert,
                toView:rootView,
                constant:-kHeight)
            NSLayoutConstraint.equalsHorizontal(
                view:alert,
                toView:rootView,
                margin:kMarginHorizontal)
            NSLayoutConstraint.height(
                view:alert,
                constant:kHeight)
            
            rootView.layoutIfNeeded()
            alert.animate(open:true)
        }
    }
    
    private convenience init(message:String)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = kCornerRadius
        layer.borderWidth = kBorderWidth
        layer.borderColor = UIColor(white:0, alpha:0.5).cgColor
        
        let blur:VBlur = VBlur.extraLight()
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.bold(size:kFontSize)
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        label.backgroundColor = UIColor.clear
        label.text = message
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.clear
        button.addTarget(
            self,
            action:#selector(actionButton(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(blur)
        addSubview(label)
        addSubview(button)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        NSLayoutConstraint.equalsVertical(
            view:label,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self,
            margin:kLabelMargin)
    }
    
    func alertTimeOut(sender timer:Timer?)
    {
        timer?.invalidate()
        animate(open:false)
    }
    
    //MARK: actions
    
    func actionButton(sender button:UIButton)
    {
        button.isUserInteractionEnabled = false
        timer?.invalidate()
        alertTimeOut(sender:timer)
    }
    
    //MARK: private
    
    private func scheduleTimer()
    {
        self.timer = Timer.scheduledTimer(
            timeInterval:kTimeOut,
            target:self,
            selector:#selector(alertTimeOut(sender:)),
            userInfo:nil,
            repeats:false)
    }
    
    private func animate(open:Bool)
    {
        if open
        {
            layoutTop.constant = kMarginTop
        }
        else
        {
            layoutTop.constant = -VAlert.kHeight
        }
        
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
        { [weak self] in
            
            self?.superview?.layoutIfNeeded()
            
        })
        { [weak self] (done:Bool) in
        
            if open
            {
                self?.scheduleTimer()
            }
            else
            {
                self?.removeFromSuperview()
            }
        }
    }
}
