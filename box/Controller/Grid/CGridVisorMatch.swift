import UIKit

class CGridVisorMatch:CController
{
    private var modelMatch:MGridVisorMatch?
    private(set) weak var model:MGridAlgoHostileItem?
    private(set) weak var viewMatch:VGridVisorMatch!
    private weak var timer:Timer?
    private let kTickInterval:TimeInterval = 0.016
    private let kFinishWait:TimeInterval = 5
    
    init(model:MGridAlgoHostileItem)
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
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        parentController.viewParent.panRecognizer.isEnabled = false
    }
    
    override func loadView()
    {
        let viewMatch:VGridVisorMatch = VGridVisorMatch(controller:self)
        self.viewMatch = viewMatch
        view = viewMatch
    }
    
    //MARK: actions
    
    func actionTick(sener timer:Timer)
    {
        viewMatch.viewBase.viewBackground.animation.setNeedsDisplay()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.modelMatch?.timerTick()
        }
    }
    
    //MARK: private
    
    private func startMatch()
    {
        guard
            
            let model:MGridAlgoHostileItem = self.model
            
        else
        {
            return
        }
        
        let energyCost:Int16 = Int16(model.credits)
        MSession.sharedInstance.settings?.energy?.spendEnergy(energyCost:energyCost)
        
        modelMatch = MGridVisorMatch(model:model, controller:self)
    }
    
    private func finishMatch()
    {
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kFinishWait)
        { [weak self] in
            
            self?.parentController.dismissAnimateOver(completion:nil)
        }
    }
    
    private func destroyHostile()
    {
        guard
            
            let model:MGridAlgoHostileItem = self.model
            
        else
        {
            return
        }
        
        let path:String = model.firebasePath
        FMain.sharedInstance.db.removeChild(path:path)
        
        NotificationCenter.default.post(
            name:Notification.destroyAlgoRendered,
            object:model)
    }
    
    private func addDefeated()
    {
        guard
            
            let model:MGridAlgoHostileItem = self.model
            
        else
        {
            return
        }
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            model.addDefeated()
        }
    }
    
    private func updateStats()
    {
        guard
            
            let model:MGridAlgoHostileItem = self.model
            
        else
        {
            return
        }
        
        model.destroySuccess()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            MSession.sharedInstance.addScore(credits:model.credits)
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            {
                MSession.sharedInstance.updateKills()
            }
        }
    }
    
    //MARK: public
    
    func back()
    {
        parentController.dismissAnimateOver(completion:nil)
    }
    
    func play()
    {
        timer?.invalidate()
        viewMatch.viewBase.viewBackground.animate()
        
        timer = Timer.scheduledTimer(
            timeInterval:kTickInterval,
            target:self,
            selector:#selector(actionTick(sener:)),
            userInfo:nil,
            repeats:true)
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.startMatch()
        }
    }
    
    func failed()
    {
        timer?.invalidate()
        addDefeated()
        
        guard
            
            let stringMatch:String = model?.matchTitle
            
        else
        {
            return
        }
        
        let stringFail:String = String(
            format:NSLocalizedString("CGridVisorMatch_titleFail", comment:""),
            stringMatch)
        viewMatch.viewBase.viewBackground.success(message:stringFail)
        
        finishMatch()
    }
    
    func success()
    {
        timer?.invalidate()
        updateStats()
        destroyHostile()
        
        guard
            
            let stringMatch:String = model?.matchTitle
            
        else
        {
            return
        }
        
        let stringSuccess:String = String(
            format:NSLocalizedString("CGridVisorMatch_titleSuccess", comment:""),
            stringMatch)
        viewMatch.viewBase.viewBackground.success(message:stringSuccess)
    
        finishMatch()
    }
}
