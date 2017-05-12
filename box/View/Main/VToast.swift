import UIKit

class VToast:UIView
{
    private static let kHeight:CGFloat = 65
    private weak var layoutTop:NSLayoutConstraint!
    private weak var timer:Timer?
    private let kAnimationDuration:TimeInterval = 0.3
    private let kTimeOut:TimeInterval = 6
    private let kFontSize:CGFloat = 15
    private let kLabelMargin:CGFloat = 9
    
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
            
            toast.layoutTop = NSLayoutConstraint.topToTop(
                view:toast,
                toView:rootView,
                constant:-kHeight)
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
        let height:CGFloat = VToast.kHeight
        
        if open
        {
            let screenHeight:CGFloat = UIScreen.main.bounds.size.height
            let remain:CGFloat = screenHeight - height
            let top:CGFloat = remain / 2.0
            layoutTop.constant = top
        }
        else
        {
            layoutTop.constant = -height
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
