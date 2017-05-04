import UIKit

class CGridVisorMatch:CController
{
    private var modelMatch:MGridVisorMatch?
    private(set) weak var model:MGridAlgoItemHostile?
    private weak var viewMatch:VGridVisorMatch!
    private weak var timer:Timer?
    private let kTimeInterval:TimeInterval = 3
    
    init(model:MGridAlgoItemHostile)
    {
        self.model = model
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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        guard
            
            let model:MGridAlgoItemHostile = self.model
        
        else
        {
            return
        }
        
        let energyCost:Int16 = Int16(model.credits)
        MSession.sharedInstance.settings?.energy?.spendEnergy(energyCost:energyCost)
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        if modelMatch == nil
        {
            guard
                
                let model:MGridAlgoItemHostile = self.model
                
            else
            {
                return
            }
            
            let controllersCount:Int = parentController.childViewControllers.count
            let prevController:Int = controllersCount - 2
            
            if prevController > 0
            {
                if let _:CGridVisorDetail = parentController.childViewControllers[prevController] as? CGridVisorDetail
                {
                    parentController.popSilent(removeIndex:prevController)
                }
            }
            
            modelMatch = MGridVisorMatch(model:model, controller:self)
            
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
            
            self?.modelMatch?.timerTick()
        }
    }
    
    //MARK: private
    
    private func finishMatch()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.parentController.dismissAnimateOver(completion:nil)
        }
    }
    
    private func destroyHostile()
    {
        guard
            
            let model:MGridAlgoItemHostile = self.model
            
        else
        {
            return
        }
        
        let path:String = model.firebasePath()
        FMain.sharedInstance.db.removeChild(path:path)
        
        NotificationCenter.default.post(
            name:Notification.destroyAlgoRendered,
            object:model)
    }
    
    private func updateStats()
    {
        guard
            
            let model:MGridAlgoItemHostile = self.model
            
        else
        {
            return
        }
        
        model.destroySuccess()
        MSession.sharedInstance.addScore(credits:model.credits)
    }
    
    //MARK: public
    
    func failed()
    {
        timer?.invalidate()
        finishMatch()
        
        guard
            
            let stringMatch:String = model?.titleMatch()
            
        else
        {
            return
        }
        
        let stringFail:String = String(
            format:NSLocalizedString("CGridVisorMatch_titleFail", comment:""),
            stringMatch)
        
        VAlert.messageOrange(message:stringFail)
    }
    
    func success()
    {
        timer?.invalidate()
        updateStats()
        destroyHostile()
        finishMatch()
        
        guard
            
            let stringMatch:String = model?.titleMatch()
            
        else
        {
            return
        }
        
        let stringSuccess:String = String(
            format:NSLocalizedString("CGridVisorMatch_titleSuccess", comment:""),
            stringMatch)
        
        VAlert.messageBlue(message:stringSuccess)
    }
}
