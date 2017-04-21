import UIKit

class CGridVisorDebug:CController
{
    private weak var viewDebug:VGridVisorDebug!
    private weak var model:MGridAlgoItemHostileBug!
    private weak var timer:Timer?
    private var firstTime:Bool
    private var timesTried:Int
    private let tryTimes:Int
    private let difficulty:UInt32
    private let kDifficultyDivisor:CGFloat = 30
    private let kAddDifficulty:CGFloat = 1
    private let kTimeInterval:TimeInterval = 3
    private let kMinTryTimes:Int = 1
    
    init(model:MGridAlgoItemHostileBug)
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
        
        print("dif \(difficulty) trytimes \(tryTimes)")
        
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
    }
    
    override func loadView()
    {
        let viewDebug:VGridVisorDebug = VGridVisorDebug(controller:self)
        self.viewDebug = viewDebug
        view = viewDebug
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
        
        VAlert.messageOrange(
            message:NSLocalizedString("CGridVisorDebug_failed", comment:""))
        
        finishDebug()
    }
    
    private func success()
    {
        timer?.invalidate()
        
        VAlert.messageBlue(
            message:NSLocalizedString("CGridVisorDebug_success", comment:""))
        
        finishDebug()
    }
    
    private func finishDebug()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.parentController.dismissAnimateOver(completion:nil)
        }
    }
}
