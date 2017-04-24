import UIKit

class CGridVisorMatch:CController
{
    private(set) weak var model:MGridAlgoItemHostile!
    private weak var viewMatch:VGridVisorMatch!
    private weak var timer:Timer?
    private var firstTime:Bool
    private var timesTried:Int
    private let tryTimes:Int
    private let difficulty:UInt32
    private let kDifficultyDivisor:CGFloat = 30
    private let kAddDifficulty:CGFloat = 1
    private let kTimeInterval:TimeInterval = 3
    private let kMinTryTimes:Int = 1
    
    init(model:MGridAlgoItemHostile)
    {
        self.model = model
        firstTime = true
        timesTried = 0
        
        var tryTimes:Int = model.level
        
        if let userLevel:Int16 = MSession.sharedInstance.settings?.user?.level
        {
            tryTimes -= Int(userLevel)
        }
        
        if tryTimes < kMinTryTimes
        {
            tryTimes = kMinTryTimes
        }
        
        self.tryTimes = tryTimes
        
        let rawDifficulty:CGFloat = ceil(CGFloat(model.credits) / kDifficultyDivisor)
        let totalDifficulty:CGFloat = rawDifficulty + kAddDifficulty
        difficulty = UInt32(totalDifficulty)
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        timer?.invalidate()
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        if firstTime
        {
            firstTime = false
            
            let controllersCount:Int = parentController.childViewControllers.count
            let prevController:Int = controllersCount - 2
            
            if prevController > 0
            {
                if let _:CGridVisorDetail = parentController.childViewControllers[prevController] as? CGridVisorDetail
                {
                    parentController.popSilent(removeIndex:prevController)
                }
            }
            
            timer = Timer.scheduledTimer(
                timeInterval:kTimeInterval,
                target:self,
                selector:#selector(actionTimer(sender:)),
                userInfo:nil,
                repeats:true)
        }
        
        parentController.viewParent.panRecognizer.isEnabled = false
    }
    
    override func loadView()
    {
        let viewMatch:VGridVisorMatch = VGridVisorMatch(controller:self)
        self.viewMatch = viewMatch
        view = viewMatch
    }
    
    //MARK: actions
    
    func actionTimer(sender timer:Timer)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            guard
                
                let timesTried:Int = self?.timesTried,
                let tryTimes:Int = self?.tryTimes
                
            else
            {
                return
            }
            
            if timesTried < tryTimes
            {
                self?.timesTried += 1
                self?.rollDices()
            }
            else
            {
                self?.success()
            }
        }
    }
    
    //MARK: private
    
    private func rollDices()
    {
        let diceResult:UInt32 = arc4random_uniform(difficulty)
        
        if diceResult > 0
        {
            failed()
        }
    }
    
    private func failed()
    {
        timer?.invalidate()
        finishMatch()
        
        guard
        
            let stringFailed:String = model.titleFailed()
        
        else
        {
            return
        }
        
        VAlert.messageOrange(message:stringFailed)
    }
    
    private func success()
    {
        timer?.invalidate()
        finishMatch()
        
        guard
            
            let stringSuccess:String = model.titleSuccess()
            
        else
        {
            return
        }
        
        VAlert.messageBlue(message:stringSuccess)
    }
    
    private func finishMatch()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.parentController.dismissAnimateOver(completion:nil)
        }
    }
}
