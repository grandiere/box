import UIKit

class VBoardsBarSelector:UIView
{
    private weak var controller:CBoards!
    private weak var itemScore:VBoardsBarSelectorItem!
    private weak var itemKills:VBoardsBarSelectorItem!
    private weak var viewIndicator:VBoardsBarSelectorIndicator!
    private weak var layoutIndicatorLeft:NSLayoutConstraint!
    private var gestureLastX:CGFloat?
    private let kItemMultiplier:CGFloat = 0.5
    private let kIndicatorMultiplier:CGFloat = 0.5
    private let kBackgroundMargin:CGFloat = 1
    private let kAnimationDuration:TimeInterval = 0.4
    
    init(controller:CBoards)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let viewBackground:VBoardsBarSelectorBackground = VBoardsBarSelectorBackground()
        
        let itemScore:VBoardsBarSelectorItem = VBoardsBarSelectorItem(
            title:NSLocalizedString("VBoardsBarSelector_itemScore", comment:""))
        itemScore.addTarget(
            self,
            action:#selector(actionScore(sender:)),
            for:UIControlEvents.touchUpInside)
        self.itemScore = itemScore
        
        let itemKills:VBoardsBarSelectorItem = VBoardsBarSelectorItem(
            title:NSLocalizedString("VBoardsBarSelector_itemKills", comment:""))
        itemKills.addTarget(
            self,
            action:#selector(actionKills(sender:)),
            for:UIControlEvents.touchUpInside)
        self.itemKills = itemKills
        
        let viewIndicator:VBoardsBarSelectorIndicator = VBoardsBarSelectorIndicator()
        self.viewIndicator = viewIndicator
        
        let panGesture:UIPanGestureRecognizer = UIPanGestureRecognizer(
            target:self,
            action:#selector(actionPanning(sender:)))
        
        addSubview(viewBackground)
        addSubview(viewIndicator)
        addSubview(itemScore)
        addSubview(itemKills)
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
            view:itemScore,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:itemScore,
            toView:self)
        NSLayoutConstraint.width(
            view:itemScore,
            toView:self,
            multiplier:kItemMultiplier)
        
        NSLayoutConstraint.equalsVertical(
            view:itemKills,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:itemKills,
            toView:self)
        NSLayoutConstraint.width(
            view:itemKills,
            toView:self,
            multiplier:kItemMultiplier)
        
        buttonScore()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionScore(sender button:UIButton)
    {
        indicatorScore(animated:true)
    }
    
    func actionKills(sender button:UIButton)
    {
        indicatorKills(animated:true)
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
            buttonKills()
        }
        else
        {
            buttonScore()
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
            indicatorKills(animated:true)
        }
        else
        {
            indicatorScore(animated:true)
        }
    }
    
    private func buttonScore()
    {
        itemScore.isSelected = true
        itemKills.isSelected = false
    }
    
    private func buttonKills()
    {
        itemScore.isSelected = false
        itemKills.isSelected = true
    }
    
    private func indicatorScore(animated:Bool)
    {
        controller.model.sortScore()
        buttonScore()
        
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
    
    private func indicatorKills(animated:Bool)
    {
        controller.model.sortKills()
        buttonKills()
        
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
