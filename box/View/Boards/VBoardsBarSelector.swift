import UIKit

class VBoardsBarSelector:UIView
{
    private weak var controller:CBoards!
    private weak var itemDeposit:VMovementsMenuTypeItem!
    private weak var itemExpense:VMovementsMenuTypeItem!
    private weak var viewIndicator:VMovementsMenuTypeIndicator!
    private weak var layoutIndicatorLeft:NSLayoutConstraint!
    private var gestureLastX:CGFloat?
    private let kItemMultiplier:CGFloat = 0.5
    private let kIndicatorMultiplier:CGFloat = 0.5
    private let kBackgroundMargin:CGFloat = 1
    private let kAnimationDuration:TimeInterval = 0.4
    
    init(controller:CMovements)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let viewBackground:VMovementsMenuTypeBackground = VMovementsMenuTypeBackground()
        
        let itemDeposit:VMovementsMenuTypeItem = VMovementsMenuTypeItem(
            title:NSLocalizedString("VMovementsMenuType_itemDeposit", comment:""))
        itemDeposit.addTarget(
            self,
            action:#selector(actionDeposit(sender:)),
            for:UIControlEvents.touchUpInside)
        self.itemDeposit = itemDeposit
        
        let itemExpense:VMovementsMenuTypeItem = VMovementsMenuTypeItem(
            title:NSLocalizedString("VMovementsMenuType_itemExpense", comment:""))
        itemExpense.addTarget(
            self,
            action:#selector(actionExpense(sender:)),
            for:UIControlEvents.touchUpInside)
        self.itemExpense = itemExpense
        
        let viewIndicator:VMovementsMenuTypeIndicator = VMovementsMenuTypeIndicator()
        self.viewIndicator = viewIndicator
        
        let panGesture:UIPanGestureRecognizer = UIPanGestureRecognizer(
            target:self,
            action:#selector(actionPanning(sender:)))
        
        addSubview(viewBackground)
        addSubview(viewIndicator)
        addSubview(itemExpense)
        addSubview(itemDeposit)
        addGestureRecognizer(panGesture)
        
        NSLayoutConstraint.equals(
            view:viewBackground,
            toView:self,
            margin:kBackgroundMargin)
        
        NSLayoutConstraint.equalsVertical(
            view:viewIndicator,
            toView:self)
        layoutIndicatorLeft = NSLayoutConstraint.leftToLeft(
            view:viewIndicator,
            toView:self)
        NSLayoutConstraint.width(
            view:viewIndicator,
            toView:self,
            multiplier:kIndicatorMultiplier)
        
        NSLayoutConstraint.equalsVertical(
            view:itemExpense,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:itemExpense,
            toView:self)
        NSLayoutConstraint.width(
            view:itemExpense,
            toView:self,
            multiplier:kItemMultiplier)
        
        NSLayoutConstraint.equalsVertical(
            view:itemDeposit,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:itemDeposit,
            toView:self)
        NSLayoutConstraint.width(
            view:itemDeposit,
            toView:self,
            multiplier:kItemMultiplier)
        
        let deposit:Bool = controller.isDeposit
        
        DispatchQueue.main.async
            { [weak self] in
                
                self?.layoutIfNeeded()
                
                if deposit
                {
                    self?.indicatorDeposit(animated:false)
                }
                else
                {
                    self?.indicatorExpense(animated:false)
                }
        }
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionExpense(sender button:UIButton)
    {
        controller.isDeposit = false
        indicatorExpense(animated:true)
    }
    
    func actionDeposit(sender button:UIButton)
    {
        controller.isDeposit = true
        indicatorDeposit(animated:true)
    }
    
    func actionPanning(sender panGesture:UIPanGestureRecognizer)
    {
        switch panGesture.state
        {
        case UIGestureRecognizerState.began:
            
            gestureBegan(gesture:panGesture)
            
            break
            
        case UIGestureRecognizerState.possible,
             UIGestureRecognizerState.changed:
            
            gestureMoving(gesture:panGesture)
            
            break
            
        case UIGestureRecognizerState.cancelled,
             UIGestureRecognizerState.ended,
             UIGestureRecognizerState.failed:
            
            gestureEnded(gesture:panGesture)
            
            break
        }
    }
    
    //MARK: private
    
    private func indicatorMaxX() -> CGFloat
    {
        return bounds.midX
    }
    
    private func gestureBegan(gesture:UIPanGestureRecognizer)
    {
        let location:CGPoint = gesture.location(in:self)
        gestureLastX = location.x
    }
    
    private func gestureMoving(gesture:UIPanGestureRecognizer)
    {
        guard
            
            let gestureLastX:CGFloat = self.gestureLastX
            
            else
        {
            return
        }
        
        let location:CGPoint = gesture.location(in:self)
        let newX:CGFloat = location.x
        let deltaX:CGFloat = newX - gestureLastX
        let maxX:CGFloat = indicatorMaxX()
        let midX:CGFloat = maxX / 2.0
        var indicatorNewX:CGFloat = layoutIndicatorLeft.constant + deltaX
        
        if indicatorNewX < 0
        {
            indicatorNewX = 0
        }
        else if indicatorNewX > maxX
        {
            indicatorNewX = maxX
        }
        
        if indicatorNewX > midX
        {
            buttonDeposit()
        }
        else
        {
            buttonExpense()
        }
        
        layoutIndicatorLeft.constant = indicatorNewX
        self.gestureLastX = newX
    }
    
    private func gestureEnded(gesture:UIPanGestureRecognizer)
    {
        let maxX:CGFloat = indicatorMaxX()
        let midX:CGFloat = maxX / 2.0
        
        if layoutIndicatorLeft.constant > midX
        {
            indicatorDeposit(animated:true)
        }
        else
        {
            indicatorExpense(animated:true)
        }
    }
    
    private func buttonDeposit()
    {
        itemDeposit.isSelected = true
        itemExpense.isSelected = false
    }
    
    private func buttonExpense()
    {
        itemDeposit.isSelected = false
        itemExpense.isSelected = true
    }
    
    private func indicatorExpense(animated:Bool)
    {
        buttonExpense()
        
        let duration:TimeInterval
        
        if animated
        {
            duration = kAnimationDuration
        }
        else
        {
            duration = 0
        }
        
        layoutIndicatorLeft.constant = 0
        
        UIView.animate(withDuration:duration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
    
    private func indicatorDeposit(animated:Bool)
    {
        buttonDeposit()
        
        let duration:TimeInterval
        
        if animated
        {
            duration = kAnimationDuration
        }
        else
        {
            duration = 0
        }
        
        layoutIndicatorLeft.constant = indicatorMaxX()
        
        UIView.animate(withDuration:duration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
}
