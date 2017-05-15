import UIKit

class VAlert:UIView
{
    private static let kHeight:CGFloat = 50
    private weak var layoutTop:NSLayoutConstraint!
    private weak var timer:Timer?
    private let kAnimationDuration:TimeInterval = 0.3
    private let kTimeOut:TimeInterval = 5
    private let kFontSize:CGFloat = 15
    private let kLabelMargin:CGFloat = 9
    
    class func messageOrange(message:String)
    {
        VAlert.message(message:message, color:UIColor.gridOrange)
    }
    
    class func messageBlue(message:String)
    {
        VAlert.message(message:message, color:UIColor.gridBlue)
    }
    
    private class func message(message:String, color:UIColor)
    {
        DispatchQueue.main.async
        {
            let alert:VAlert = VAlert(
                message:message,
                color:color)
            
            let rootView:UIView = UIApplication.shared.keyWindow!.rootViewController!.view
            rootView.addSubview(alert)
            
            alert.layoutTop = NSLayoutConstraint.topToTop(
                view:alert,
                toView:rootView,
                constant:-kHeight)
            NSLayoutConstraint.equalsHorizontal(
                view:alert,
                toView:rootView)
            NSLayoutConstraint.height(
                view:alert,
                constant:kHeight)
            
            rootView.layoutIfNeeded()
            alert.animate(open:true)
        }
    }
    
    private convenience init(message:String, color:UIColor)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = color
        translatesAutoresizingMaskIntoConstraints = false
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.bold(size:kFontSize)
        label.textColor = UIColor.white
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
        
        addSubview(label)
        addSubview(button)
        
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
            layoutTop.constant = 0
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
