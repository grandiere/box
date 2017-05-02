import UIKit

class CGridVisorTake:CController
{
    private var modelTake:MGridVisorTake?
    private(set) weak var model:MGridAlgoItemAid!
    private(set) weak var viewTake:VGridVisorTake!
    
    init(model:MGridAlgoItemAid)
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
    
    func done()
    {
        parentController.dismissAnimateOver(completion:nil)
    }
}
