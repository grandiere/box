import UIKit

class VToast:UIView
{
    private static let kHeight:CGFloat = 52
    private weak var timer:Timer?
    private let kAnimationDuration:TimeInterval = 0.4
    private let kTimeOut:TimeInterval = 3.5
    private let kFontSize:CGFloat = 17
    private let kLabelMargin:CGFloat = 15
    
    class func messageOrange(message:String)
    {
        VToast.message(message:message, color:UIColor.gridOrange)
    }
    
    class func messageBlue(message:String)
    {
        VToast.message(message:message, color:UIColor.gridBlue)
    }
    
    private class func message(message:String, color:UIColor)
    {
        DispatchQueue.main.async
        {
            let toast:VToast = VToast(
                message:message,
                color:color)
            
            let rootView:UIView = UIApplication.shared.keyWindow!.rootViewController!.view
            rootView.addSubview(toast)
            
            let screenHeight:CGFloat = UIScreen.main.bounds.size.height
            let remain:CGFloat = screenHeight - kHeight
            let top:CGFloat = remain / 2.0
            
            NSLayoutConstraint.topToTop(
                view:toast,
                toView:rootView,
                constant:top)
            NSLayoutConstraint.equalsHorizontal(
                view:toast,
                toView:rootView)
            NSLayoutConstraint.height(
                view:toast,
                constant:kHeight)
            
            rootView.layoutIfNeeded()
            toast.animate(open:true)
        }
    }
    
    private convenience init(message:String, color:UIColor)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = color
        alpha = 0
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
        let alpha:CGFloat
        
        if open
        {
            alpha = 1
        }
        else
        {
            alpha = 0
        }
        
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
            { [weak self] in
                
                self?.alpha = alpha
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
