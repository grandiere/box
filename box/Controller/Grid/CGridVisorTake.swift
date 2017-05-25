import UIKit

class CGridVisorTake:CController
{
    private var modelTake:MGridVisorTake?
    private weak var model:MGridAlgoAidItem?
    private(set) weak var viewTake:VGridVisorTake!
    
    init(model:MGridAlgoAidItem)
    {
        self.model = model
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        if modelTake == nil
        {
            guard
                
                let model:MGridAlgoItemAid = self.model
            
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
            
            modelTake = MGridVisorTake(controller:self, model:model)
        }
        
        parentController.viewParent.panRecognizer.isEnabled = false
    }
    
    override func loadView()
    {
        let viewTake:VGridVisorTake = VGridVisorTake(controller:self)
        self.viewTake = viewTake
        view = viewTake
    }
    
    //MARK: public
    
    func destroyAid()
    {
        guard
        
            let model:MGridAlgoItemAid = self.model
        
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
    
    func done()
    {
        parentController.dismissAnimateOver(completion:nil)
    }
}
