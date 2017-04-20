import UIKit

class CGridVisorDebug:CController
{
    private weak var viewDebug:VGridVisorDebug!
    private weak var model:MGridAlgoItemHostileBug!
    private var firstTime:Bool
    private weak var timer:Timer?
    private let kTimeInterval:TimeInterval = 0.1
    
    init(model:MGridAlgoItemHostileBug)
    {
        self.model = model
        firstTime = true
        
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
        
    }
}
