import UIKit

class CGridVisorDebug:CController
{
    private(set) weak var model:MGridAlgoItemHostileBug!
    private weak var viewDebug:VGridVisorDebug!
    private var firstTime:Bool
    
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
        }
    }
    
    override func loadView()
    {
        let viewDebug:VGridVisorDebug = VGridVisorDebug(controller:self)
        self.viewDebug = viewDebug
        view = viewDebug
    }
}
